import 'package:flutter/material.dart';
import 'package:lock_app/services/user_data.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

    

  @override
  Widget build(BuildContext context) {
    final String nomeExibicao = (
      UserData.nomeUsuario.isNotEmpty)
        ? UserData.nomeUsuario
        : "tutor";

    
    return Center(
      child: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: 20, 
          vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              alignment: Alignment.topLeft,
              height: 100,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  transform: GradientRotation(45),
                  colors: [
                    Color.fromARGB(255, 4, 54, 79),
                    Colors.black,
                    Color.fromARGB(255, 4, 54, 79),
                    Colors.black,
                  ]
                  ),
              ),
              child: Row(
                children: [
                  Text(
                    "Olá!, $nomeExibicao ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 41, 131, 181),
                      fontWeight: FontWeight.bold,
                      fontSize: 35, 
                     ),
                    ),
                    SizedBox(width: 40,),
                   CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(UserData.caminhoFoto),
                   ),
                ],
              ),
            ),  
          ],
        ),
      ),
    );
  }
}