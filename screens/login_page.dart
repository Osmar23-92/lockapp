import 'package:flutter/material.dart';
import 'package:lock_app/screens/cadastro_page.dart';
import 'package:lock_app/screens/navigation_page.dart';
import 'package:lock_app/services/user_data.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginPage extends StatefulWidget {
 
  final String? emailCadastrado;
  final String? senhaCadastrada;

  const LoginPage({
    super.key,
    this.emailCadastrado,
    this.senhaCadastrada,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _senhaController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.emailCadastrado ?? '');
    _senhaController = TextEditingController(text: widget.senhaCadastrada ?? '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

   Future<void> verificarPermissoesDoTutor() async {
     if (!await Permission.systemAlertWindow.isGranted) {
       await Permission.systemAlertWindow.request();
      }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 50,
          ),
          child: Column(
           
            spacing: 20, 
            children: [
               
              
              Image.asset(
                "asset/images/logo.png",
                width: 150,
              ),

               Text(
                "LockApp",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 4, 54, 79),
                ),
              ),

               Text(
                "Acesso do Tutor",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 41, 131, 181),
                ),
              ),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon:  Icon(Icons.email),
                  prefixIconColor:  Color.fromARGB(255, 41, 131, 181),
                  labelText: "E-mail:",
                  labelStyle:  TextStyle(
                    color: Color.fromARGB(255, 4, 54, 79), 
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              TextField(
                controller: _senhaController,
                obscureText: true, 
                decoration: InputDecoration(
                  prefixIcon:  Icon(Icons.lock),
                  prefixIconColor:  Color.fromARGB(255, 41, 131, 181),
                  labelText: "Senha:",
                  labelStyle:  TextStyle(
                    color: Color.fromARGB(255, 4, 54, 79),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              
              SizedBox(
                height: 50,
                width: double.infinity, 
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle:  TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor:  Color.fromARGB(255, 41, 131, 181),
                    foregroundColor:  Color.fromARGB(255, 4, 54, 79),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), 
                    ),
                  ),
                  onPressed: () async {
                    final emailDigitado = _emailController.text.trim();
                    final senhaDigitada = _senhaController.text.trim();
                    
                    if (
                      emailDigitado.isEmpty || senhaDigitada.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                          content: Text(
                            "Por favor, preencha todos os campos!",
                            ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return; 
                    }

                    
                    if (emailDigitado == UserData.emailCadastrado &&
                        senhaDigitada == UserData.senhaCadastrada &&
                        UserData.emailCadastrado.isNotEmpty) {
                       try {
                       await verificarPermissoesDoTutor(); 
                       } catch (e) {
                        print("Erro ao solicitar permissão: $e");
                       }
                       if (!mounted) return;

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  NavigationPage(),
                        ),
                      );
                    } 
                    
                    else 
                    {
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                          content: Text(
                            "Usuário não cadastrado ou dados incorretos!",
                            ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    
                    }
                  },
                  child:  Text(
                    "Entrar",
                    style: TextStyle(
                      fontSize: 25,
                      ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    "Não tem conta?",
                    style: TextStyle(
                      fontSize: 15,
                      ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastroPage(),
                        ),
                      );
                    },
                    child:  Text(
                      "Cadastrar",
                      style: TextStyle(
                        color: Color.fromARGB(255, 4, 54, 79),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            
             
            ],
          ),
        ),
      ),
    );
  }
  
}