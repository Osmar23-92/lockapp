import 'package:flutter/material.dart';
import 'package:lock_app/screens/cadastro_page.dart';
import 'package:lock_app/screens/menu_page.dart';

import 'package:lock_app/services/user_data.dart';





class LoginPage extends StatelessWidget {
   LoginPage({super.key});


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
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
        
        Text("LockApp",
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
          ),),
        
        TextField(
          controller: _emailController,
         decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          prefixIconColor: Color.fromARGB(255, 41, 131, 181),
           labelText: "E-mail:",
           labelStyle:TextStyle(
            color: .fromARGB(255, 4, 54, 79),
            ) ,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
             ),
            ), 
        ),
        
        TextField(
          controller: _senhaController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            prefixIconColor: Color.fromARGB(255, 41, 131, 181),
           labelText: "Senha:",
           labelStyle: TextStyle(
            color: Color.fromARGB(255, 4, 54, 79),
           ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
             ),
            ),
        ),


        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              minimumSize: Size.fromHeight(50),
              maximumSize: Size.fromHeight(50),
              backgroundColor:  const Color.fromARGB(255, 41, 131, 181),
              foregroundColor: Color.fromARGB(255, 4, 54, 79),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(15),
              ),
            ),
            onPressed: (){
              
            if (
              _emailController.text == UserData.emailCadastrado &&
              _senhaController.text == UserData.senhaCadastrada) {
                 Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => MenuPage(),
                      ),
                    );
                } else {
                  ScaffoldMessenger.of(context) .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "E-mail ou senha incorretos!"),
                        backgroundColor: Colors.red),
                        );
                }
            },
             child: 
             Text(
              "Entrar",
             style: TextStyle(
              fontSize: 25,
                ),
               ),
              ),
        ),
           

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Não tem conta?",
              style: TextStyle(
                fontSize: 15,
               ),
              ),

            TextButton(
              onPressed: (){
                Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => CadastroPage(),
                      ),
                    );
              }, child: Text(
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
    );
  }
}