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
      
      backgroundColor: const Color.fromARGB(255, 144, 220, 254),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          spacing: 30,
          children: [
        
        Image.asset(
          "asset/images/logo.jpeg",
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
           labelText: "Nome:",
            border: OutlineInputBorder()),
          ),
        
        TextField(
          controller: _emailCadastroController,
         decoration: InputDecoration(
           labelText: "E-mail:",
            border: OutlineInputBorder()), 
        ),
        
        TextField(
          controller: _senhaCadastroController,
          decoration: InputDecoration(
           labelText: "Crie uma senha:",
            border: OutlineInputBorder()),
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
                          
                          backgroundColor: const Color.fromARGB(255, 41, 131, 181),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: (){
                          UserData.emailCadastrado = _emailCadastroController.text;
                          UserData.senhaCadastrada = _senhaCadastroController.text;
                        ScaffoldMessenger.of(context). showSnackBar( 
                          const SnackBar(
                            content: Text("Cadastro realizado com sucesso!"),
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
                            color: const Color.fromARGB(255, 4, 54, 79),
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
                          
                          backgroundColor: const Color.fromARGB(255, 41, 131, 181),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: (){
                          _nomeCadastroController.clear();
                          _emailCadastroController.clear();
                          _senhaCadastroController.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Campos limpos!"),
                              duration: Duration(milliseconds: 500),
                              ),
                            
                              );
                        }, 
                        child: Text(
                          "Limpar",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 4, 54, 79),
                          ),),
                      ),
                    ),
                  ),
                ],
              )
        
          ],
        
          
        ),
      ),
    );
  }
}