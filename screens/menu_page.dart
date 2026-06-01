import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lock_app/services/user_data.dart';
import 'package:flutter/foundation.dart';


class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    final String nomeExibicao = (UserData.nomeUsuario.isNotEmpty) ? UserData.nomeUsuario : "tutor";
    final String nomeSecundario = UserData.nomePerfilSecundario;
    final String fotoSecundario = UserData.fotoPerfilSecundario;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                gradient: const LinearGradient(
                  transform: GradientRotation(45),
                  colors: [
                    Color.fromARGB(255, 4, 54, 79),
                    Color.fromARGB(255, 2, 24, 36),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "   Olá! $nomeExibicao ",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 41, 131, 181),
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color.fromARGB(0, 158, 158, 158),
                      child: Icon(
                        Icons.shield_outlined,
                        color: Color.fromARGB(255, 41, 131, 181),
                        size: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Perfil sob monitoramento",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: UserData.perfis.length,
                itemBuilder: (context, index) {
                  final perfil = UserData.perfis[index];

                  return InkWell(
                    onTap: () {
                      setState(() {
                       
                        UserData.nomePerfilSecundario = perfil["name"] ?? "";
                        UserData.fotoPerfilSecundario = perfil["image"] ?? "";
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          CircleAvatar(
                               radius: 25,
                              backgroundImage: perfil["image"] != null && perfil["image"].toString().isNotEmpty
                         ? (kIsWeb
                         ? NetworkImage(perfil["image"].toString()) as ImageProvider
                         : FileImage(File(perfil["image"].toString())) as ImageProvider)
                      : null,
                           child: perfil["image"] == null || perfil["image"].toString().isEmpty
                         ? const Icon(Icons.person)
                         : null,
                             ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 60,
                            child: Text(
                              perfil["name"] ?? "",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            nomeSecundario.isNotEmpty
                ? Card(
                  color: Color.fromARGB(255, 4, 54, 79),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: const Color.fromARGB(255, 41, 131, 181),
                        backgroundImage: fotoSecundario.isNotEmpty
                            ? FileImage(File(fotoSecundario))
                            : null,
                        child: fotoSecundario.isEmpty
                            ? const Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 41, 131, 181),
                              )
                            : null,
                      ),
                      title: Text(
                        nomeSecundario,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 41, 131, 181),
                        ),
                      ),
                      subtitle: const Text(
                        "Acesso restrito ativo",
                        style: TextStyle(
                          color: Color.fromARGB(255, 41, 131, 181),
                          fontSize: 15,
                        ),),
                      trailing: const Icon(
                        Icons.circle,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 4, 54, 79),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color.fromARGB(255, 4, 54, 79),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.person_search,
                          size: 40,
                          color: Color.fromARGB(255, 41, 131, 181),
                        ),
                        Text(
                          "Nenhum perfil selecionado.\nClique em um dos perfis acima para ativar.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 41, 131, 181),
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