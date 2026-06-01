import 'package:flutter/material.dart';
import 'dart:io';
import 'package:lock_app/services/user_data.dart';
import 'package:image_picker/image_picker.dart';

class PerfisPage extends StatefulWidget {
  const PerfisPage({super.key});

  @override
  State<PerfisPage> createState() => _PerfisPageState();
}

class _PerfisPageState extends State<PerfisPage> {

 @override
  void initState() {
    super.initState();

    users = UserData.perfis.map((perfil) {
      return {
        "name":perfil["name"],
        "image":File(perfil["image"]),
        "color1": Colors.purple,
        "color2": Colors.deepPurpleAccent,
      };
    }).toList();
  }

  List<Map<String, dynamic>> users = [];

  void deletarPerfil(int index) {
    setState(() {
      users.removeAt(index);
      UserData.perfis.removeAt(index);
    });
  }

  ImageProvider getImagem(dynamic imagem) {
  if (imagem is File) {
    return FileImage(imagem);
  }
  return AssetImage(imagem);
}

  File? imagemSelecionada;

    Future<void> escolherImagem() async {
      final picker = ImagePicker();

      final XFile? imagem = await picker.pickImage(
        source: ImageSource.gallery,
     );

      if (imagem != null) {
        setState(() {
         imagemSelecionada = File(imagem.path);
       });
     }
    } 

       void adicionarPerfil(String nome, File imagem) {
    setState(() {
    users.add({
      "name": nome,
      "image": imagem,
      "color1": Colors.purple,
      "color2": Colors.deepPurpleAccent,
    });

      UserData.perfis.add({
      "name": nome,
      "image": imagem.path,
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
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 35,
        ),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                 TextEditingController nomeController =
      TextEditingController();

  File? foto;

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

                    final XFile? imagem =
                        await picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (imagem != null) {
                      setDialogState(() {
                        foto = File(imagem.path);
                      });
                    }
                  },

                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue,

                    backgroundImage: foto != null
                            ? FileImage(foto!)
                            : null,
                            
                    child: foto == null
                        ? const Icon(Icons.add_a_photo)
                        : null,
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: "Nome",
                  ),
                ),
              ],
            ),

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancelar"),
              ),

              ElevatedButton(
                onPressed: () {
                  if (nomeController.text.isNotEmpty &&
                      foto != null) {

                    adicionarPerfil(
                      nomeController.text,
                      foto!,
                    );

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


              
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),

      body: ListView.builder(
        physics: BouncingScrollPhysics(),
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

              gradient: LinearGradient(
                colors: [
                  user["color1"],
                  user["color2"],
                ],
              ),

              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),

            child: Row(
              children: [

               CircleAvatar(
               radius: 35,
               backgroundImage: getImagem(user["image"]),
            ),
            
                const SizedBox(width: 20),

                Expanded(
                  child: Text(
                    user["name"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: IconButton(
                    onPressed: () {
                    TextEditingController nomeController =
      TextEditingController(text: user["name"]);

  Color cor1 = user["color1"];
  Color cor2 = user["color2"];

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

                CircleAvatar(
                 radius: 40,
                 backgroundImage: getImagem(user["image"]),
              ),

                TextButton.icon(
                  onPressed: () async {
                    final picker = ImagePicker();

                    final XFile? imagem = await picker.pickImage(source: ImageSource.gallery
                    );

                    if (imagem != null){
                      setState(() {
                        users[index]["image"] = File(imagem.path);

                        UserData.perfis[index]["image"] =
                        imagem.path;
                      });

                      setDialogState(() {});
                    }
                  },

                  icon: const Icon(Icons.image),
                  label: const Text("Mudar imagem"),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: "Nome",
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,

                  children: [

                    GestureDetector(
                      onTap: () {
                        setDialogState(() {
                          cor1 = Colors.blue;
                          cor2 = Colors.lightBlueAccent;
                        });
                      },

                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        setDialogState(() {
                          cor1 = Colors.red;
                          cor2 = Colors.orange;
                        });
                      },

                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        setDialogState(() {
                          cor1 = Colors.green;
                          cor2 = Colors.lightGreen;
                        });
                      },

                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            actions: [

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text("Cancelar"),
              ),

              ElevatedButton(
                onPressed: () {

                  setState(() {
                    users[index]["name"] =
                        nomeController.text;

                    UserData.perfis[index]["name"] =
                        nomeController.text;

                    users[index]["color1"] = cor1;
                    users[index]["color2"] = cor2;
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

                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: IconButton(
                    onPressed: () async {

    bool? confirmar = await showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: Text("Excluir perfil"),
          content: Text(
            "Tem certeza que deseja excluir este perfil?",
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },

              child: Text("Cancelar"),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },

              child: Text("Excluir"),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      deletarPerfil(index);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Perfil excluído com sucesso"),
        ),
      );
    }
  },


                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                  ),
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