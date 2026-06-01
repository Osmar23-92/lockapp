import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:lock_app/services/user_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart'; // IMPORTANTE: Mantido para o MethodChannel funcionar

class PerfisPage extends StatefulWidget {
  const PerfisPage({super.key});

  @override
  State<PerfisPage> createState() => _PerfisPageState();
}

class _PerfisPageState extends State<PerfisPage> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    // Carrega os dados da sua classe de serviço
    users = UserData.perfis.map((perfil) {
      return {
        "name": perfil["name"],
        "image": perfil["image"], 
        "color1": perfil["color1"] ?? Colors.purple,
        "color2": perfil["color2"] ?? Colors.deepPurpleAccent,
      };
    }).toList();

    // Dispara a permissão correta assim que o app abre
    verificarEAtivarAcessoUso();
  }

  // SOLUÇÃO NATIVA: Abre direto a tela de Dados de Uso do Android sem depender de pacotes instáveis
  void verificarEAtivarAcessoUso() async {
    if (kIsWeb) return; // Proteção essencial para não quebrar o Chrome

    try {
      const platform = MethodChannel('com.exemplo.lock_app/permissao');
      await platform.invokeMethod('abrirConfiguracaoUso');
    } catch (e) {
      debugPrint("Erro ao abrir configurações nativas: $e");
    }
  }

  void deletarPerfil(int index) {
    setState(() {
      users.removeAt(index);
      UserData.perfis.removeAt(index);
    });
  }

  // Retorna a imagem correspondente dependendo da plataforma (Web ou Android)
  Widget exibirImagem(String caminho, {double radius = 35}) {
    if (caminho.startsWith('assets/')) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: AssetImage(caminho),
      );
    }

    if (kIsWeb) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(caminho),
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundImage: FileImage(File(caminho)),
      );
    }
  }

  void adicionarPerfil(String nome, String caminhoImagem) {
    setState(() {
      users.add({
        "name": nome,
        "image": caminhoImagem,
        "color1": Colors.purple,
        "color2": Colors.deepPurpleAccent,
      });

      UserData.perfis.add({
        "name": nome,
        "image": caminhoImagem,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black, size: 35),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                TextEditingController nomeController = TextEditingController();
                String? caminhoFoto;

                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setDialogState) {
                        return AlertDialog(
                          title: const Text("Novo Perfil"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final picker = ImagePicker();
                                  final XFile? imagem = await picker.pickImage(
                                    source: ImageSource.gallery,
                                  );

                                  if (imagem != null) {
                                    setDialogState(() {
                                      caminhoFoto = imagem.path;
                                    });
                                  }
                                },
                                child: caminhoFoto != null
                                    ? exibirImagem(caminhoFoto!, radius: 40)
                                    : const CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.blue,
                                        child: Icon(Icons.add_a_photo, color: Colors.white),
                                      ),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: nomeController,
                                decoration: const InputDecoration(labelText: "Nome"),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancelar"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (nomeController.text.isNotEmpty && caminhoFoto != null) {
                                  adicionarPerfil(nomeController.text, caminhoFoto!);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text("Salvar"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            height: 105,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(colors: [user["color1"], user["color2"]]),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
              ],
            ),
            child: Row(
              children: [
                exibirImagem(user["image"]),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    user["name"],
                    style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      TextEditingController nomeController = TextEditingController(text: user["name"]);
                      Color cor1 = user["color1"];
                      Color cor2 = user["color2"];
                      String caminhoFotoAtual = user["image"];

                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setDialogState) {
                              return AlertDialog(
                                title: const Text("Editar Perfil"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    exibirImagem(caminhoFotoAtual, radius: 40),
                                    TextButton.icon(
                                      onPressed: () async {
                                        final picker = ImagePicker();
                                        final XFile? imagem = await picker.pickImage(
                                          source: ImageSource.gallery,
                                        );

                                        if (imagem != null) {
                                          setDialogState(() {
                                            caminhoFotoAtual = imagem.path;
                                          });
                                        }
                                      },
                                      icon: const Icon(Icons.image),
                                      label: const Text("Mudar imagem"),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: nomeController,
                                      decoration: const InputDecoration(labelText: "Nome"),
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () => setDialogState(() {
                                            cor1 = Colors.blue;
                                            cor2 = Colors.lightBlueAccent;
                                          }),
                                          child: const CircleAvatar(backgroundColor: Colors.blue),
                                        ),
                                        GestureDetector(
                                          onTap: () => setDialogState(() {
                                            cor1 = Colors.red;
                                            cor2 = Colors.orange;
                                          }),
                                          child: const CircleAvatar(backgroundColor: Colors.red),
                                        ),
                                        GestureDetector(
                                          onTap: () => setDialogState(() {
                                            cor1 = Colors.green;
                                            cor2 = Colors.lightGreen;
                                          }),
                                          child: const CircleAvatar(backgroundColor: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancelar"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        users[index]["name"] = nomeController.text;
                                        users[index]["image"] = caminhoFotoAtual;
                                        users[index]["color1"] = cor1;
                                        users[index]["color2"] = cor2;

                                        UserData.perfis[index]["name"] = nomeController.text;
                                        UserData.perfis[index]["image"] = caminhoFotoAtual;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Salvar"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () async {
                      bool? confirmar = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Excluir perfil"),
                            content: const Text("Tem certeza que deseja excluir este perfil?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Cancelar"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("Excluir"),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirmar == true) {
                        deletarPerfil(index);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Perfil excluído com sucesso")),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}