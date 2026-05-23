import 'package:flutter/material.dart';
import 'package:lock_app/screens/login_page.dart';
import 'package:lock_app/services/user_data.dart';


class CadastroPage extends StatelessWidget {
  CadastroPage({super.key});

  final TextEditingController _emailCadastroController = TextEditingController();
  final TextEditingController _senhaCadastroController = TextEditingController();
  final TextEditingController _nomeCadastroController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 50,
        ),
        child: Column(
          spacing: 30,
          children: [
        
        Image.asset(
          "asset/images/logo.png",
                  width: 120,
                  ),
        
        Text("Cadastro",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 4, 54, 79),
        ),
        ),
        
        TextField(
          controller: _nomeCadastroController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            prefixIconColor: Color.fromARGB(255, 41, 131, 181),
           labelText: "Nome:",
           labelStyle: TextStyle(
            color: Color.fromARGB(255, 4, 54, 79),
           ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
             ),
            ),
          ),
        
        TextField(
          controller: _emailCadastroController,
         decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          prefixIconColor: Color.fromARGB(255, 41, 131, 181),
           labelText: "E-mail:",
           labelStyle: TextStyle(
            color: Color.fromARGB(255, 4, 54, 79),
           ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
             ),
            ), 
        ),
        
        TextField(
          controller: _senhaCadastroController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.password),
            prefixIconColor: Color.fromARGB(255, 41, 131, 181),
           labelText: "Crie uma senha:",
           labelStyle: TextStyle(
            color: Color.fromARGB(255, 4, 54, 79),
           ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
             ),
            ),
        ),
        
            Row(
                spacing: 7,
                children: [
                  
                  
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          
                          backgroundColor:  Color.fromARGB(255, 41, 131, 181),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: (){
                          _nomeCadastroController.clear();
                          _emailCadastroController.clear();
                          _senhaCadastroController.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              content: Text("Campos limpos!"),
                              duration: Duration(milliseconds: 500),
                              ),
                            
                              );
                        }, 
                        child: Text(
                          "Limpar",
                          style: TextStyle(
                            color:  Color.fromARGB(255, 4, 54, 79),
                            fontSize: 20,
                          ),),
                      ),
                    ),
                  ),

                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          
                          backgroundColor:  Color.fromARGB(255, 41, 131, 181),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: (){

                          final emailDigitado = _emailCadastroController.text.trim();
                          final senhaDigitada = _senhaCadastroController.text.trim();
                          final nomeDigitado = _nomeCadastroController.text.trim();
                    
                    if (
                     nomeDigitado.isEmpty ||  emailDigitado.isEmpty || senhaDigitada.isEmpty) {
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
                     
                    UserData.nomeUsuario = nomeDigitado;
                    UserData.emailCadastrado = emailDigitado;
                    UserData.senhaCadastrada = senhaDigitada;

                    ScaffoldMessenger.of(context).showSnackBar( 
                       SnackBar (
                        content: Text("Cadastro realizado com sucesso!"),
                        backgroundColor: Colors.green,
                      ),
                    );

                          Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                      ),
                    );
                        }, 
                        child: Text(
                          "Cadastrar",
                          style: TextStyle(
                            color:  Color.fromARGB(255, 4, 54, 79),
                            fontSize: 20,
                          ),
                        ),
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