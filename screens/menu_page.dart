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
        padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  transform: GradientRotation(90),
                  colors: [
                    Colors.black,
                    Colors.blueAccent,
                    Colors.amberAccent,
                  ],
                ),
              ),
              child: SizedBox(
                
                width: double.infinity,
                child: Text(
                  textAlign: TextAlign.left,
                  style:  TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 41, 131, 181),
                  ),
                  "Olá, $nomeExibicao!",
                ),
              ),
            ),  
          ],
        ),
      ),
    );
  }
}