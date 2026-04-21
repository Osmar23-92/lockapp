import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

// No initState:

void main() => runApp(MaterialApp(home: TelaControle()));


class TelaControle extends StatefulWidget {
  @override
  _TelaControleState createState() => _TelaControleState();
  
}

class _TelaControleState extends State<TelaControle> {
  double _nivelBrilho = 0.5;
  double _nivelVolume = 0.5;
  bool _estaBloqueado = false;

  // Controladores de senha dentro do State
  final TextEditingController _senhaController = TextEditingController();
  
  String _senhaDefinida = ""; // Começa vazia
  bool _temSenhaCriada = false;

  @override
  void initState() {
    super.initState();
    // Esconde a barra de sistema (modo imersivo)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _carregarConfiguracoes(); // Carrega a senha assim que o app abre
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  }

  // Função para carregar a senha da memória (Resolve erros de inicialização)
  Future<void> _carregarConfiguracoes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _senhaDefinida = prefs.getString('senha_user') ?? "";
      _temSenhaCriada = _senhaDefinida.isNotEmpty;
    });
  }

  // Função que estava faltando na linha 65
  Future<void> _salvarNovaSenha(String senha) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('senha_user', senha); // Escreve no "caderno" do celular
    setState(() {
      _senhaDefinida = senha;
      _temSenhaCriada = true;
    });
  }

  Future<void> ajustarBrilho(double valor) async {
    if (_estaBloqueado) return;
    try {
      await ScreenBrightness.instance.setApplicationScreenBrightness(valor);
      setState(() {
        _nivelBrilho = valor;
      });
    } catch (e) {
      print("Erro ao mudar o brilho: $e");
    }
  }

  void _gerencicarSenha(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Digite sua Senha : Crie uma nova"),
          content: TextField(
            controller: _senhaController,
            keyboardType: TextInputType.number,
            obscureText: true,
            decoration: InputDecoration(hintText: "Digite apenas números"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _senhaController.clear();
                Navigator.pop(context);
              },
              child: Text("Cancelar"),

            ),

            ElevatedButton(
              onPressed: () {
                if (!_temSenhaCriada) {

                  // Lógica de Criação

                  if (_senhaController.text.isNotEmpty) {
                    _salvarNovaSenha(_senhaController.text);
                    setState(() => _estaBloqueado = true);
                    Navigator.pop(context);
                  }
                } else {

                  // Lógica de Verificação

                  if (_senhaController.text == _senhaDefinida) {
                    setState(() => _estaBloqueado = false);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Senha incorreta!")),
                    );
                  }
                }
                _senhaController.clear();
              },
              // O texto do botão muda conforme a situação

              child: Text(_temSenhaCriada ? "Desbloquear" : "Salvar e Travar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meu App de Acessibilidade')),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- SEÇÃO DE BRILHO ---
              Icon(Icons.wb_sunny, 
                size: 50, 
                color: _estaBloqueado ? Colors.grey : Colors.orange
              ),
              SizedBox(height: 10),
              Text("Controle de Brilho: ${(_nivelBrilho * 100).round()}%"),
              Slider(
                value: _nivelBrilho,
                onChanged: _estaBloqueado ? null : (novoValor) => ajustarBrilho(novoValor),
              ),

              SizedBox(height: 30),

              // --- SEÇÃO DE VOLUME ---
              Icon(Icons.volume_up, 
                size: 50, 
                color: _estaBloqueado ? Colors.grey : Colors.blue
              ),
              SizedBox(height: 10),
              Text("Controle de Volume: ${(_nivelVolume * 100).round()}%"),
              Slider(
                value: _nivelVolume,
                onChanged: _estaBloqueado ? null : (novoVolume) {
                  VolumeController().setVolume(novoVolume);
                  setState(() => _nivelVolume = novoVolume);
                  VolumeController().listener((volume) {
                  if (_estaBloqueado) {
                    // se estiver travado e o usuário apertar o botão físico,
                    // o app "puxa" o volume de volta para o nível que estava no slider.
                    VolumeController().setVolume(_nivelVolume);
                  }
                });
                },
                
              ),

              Divider(height: 40),

              // --- BOTÃO DE TRAVA ---
              ElevatedButton.icon(
                onPressed: () {
                  if (_estaBloqueado) {
                    _gerencicarSenha(context);
                  } else {
                    setState(() => _estaBloqueado = true);
                  }
                },
                icon: Icon(_estaBloqueado ? Icons.lock : Icons.lock_open),
                label: Text(_estaBloqueado ? "DESBLOQUEAR" : "TRAVAR CONTROLES"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _estaBloqueado ? Colors.red : Colors.green,
                  foregroundColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}