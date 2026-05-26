import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lock_app/services/user_data.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

    

  @override
  Widget build(BuildContext context) {
    final String nomeExibicao = (UserData.nomeUsuario.isNotEmpty) ? UserData.nomeUsuario : "tutor";
    

    final String nomeSecundario =  UserData.nomePerfilSecundario;
    final String fotoSecundario =  UserData.fotoPerfilSecundario;

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
              alignment: Alignment.centerLeft,
              height: 100,
              width: 350,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Olá!, $nomeExibicao ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 41, 131, 181),
                      fontWeight: FontWeight.bold,
                      fontSize: 35, 
                     ),
                    ),
                    
                   Padding(
                     padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      
                     ),
                     child: CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color.fromARGB(0, 158, 158, 158),
                      child: Icon(Icons.shield_outlined,
                      color: Color.fromARGB(255, 41, 131, 181),
                      size: 60,),
                      
                     ),
                   ),
                ],
              ),
            ),  

            SizedBox(width: 30,),

            Text(
              "Perfil sob monitoramento",
              style: TextStyle(
                color: Colors.grey,
               fontSize: 14,
               fontWeight: FontWeight.bold),
              ),

              SizedBox(width: 20,),

              nomeSecundario.isNotEmpty
              ? Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Color.fromARGB(255, 41, 131, 181),
                    backgroundImage: fotoSecundario.isNotEmpty
                    ? FileImage(File(fotoSecundario))
                    : null,
                    child: fotoSecundario.isEmpty
                    ? Icon(Icons.person,
                    color: Colors.white,)
                    : null,
                  ),
                  title: Text(
                    nomeSecundario,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 4, 54, 79),
                    ),
                  ),
                  subtitle: Text("Acesso restrito ativo"),
                  trailing: Icon(Icons.circle,
                  color: Colors.green,
                  size: 14,),
                  ),
                )
                : Container(
                 width: double.infinity,
                 padding: EdgeInsets.all(20),
                 decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey
                  ),
                 ), 
                 child: Column(
                  children: [
                    Icon(Icons.person_search,
                    size: 40,
                    color: Colors.grey,),
                    Text("Nenhum perfil selecionado.\n Vá para perfis para ativar um",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                       ),
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