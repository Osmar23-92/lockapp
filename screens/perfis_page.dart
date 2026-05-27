import 'package:flutter/material.dart';
import 'package:lock_app/screens/editar_page.dart';

class PerfisPage extends StatefulWidget {
  const PerfisPage({super.key});

  @override
  State<PerfisPage> createState() => _PerfisPageState();
}

class _PerfisPageState extends State<PerfisPage> {

  List<Map<String, dynamic>> users = [
    {
      "name": "Pedro",
      "color1": Colors.blue,
      "color2": Colors.lightBlueAccent,
      "image": "assets/images/pedro.png",
    },
    {
      "name": "Lucy",
      "color1": Colors.orange,
      "color2": Colors.amber,
      "image": "assets/images/Lucy.jpg",
    },
    {
      "name": "Alice",
      "color1": Colors.pink,
      "color2": Colors.redAccent,
      "image": "assets/images/Alice.png",
    },
  ];

  void deletarPerfil(int index) {
    setState(() {
      users.removeAt(index);
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
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),

      body: ListView.builder(
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
                  backgroundImage: AssetImage(
                    user["image"],
                  ),
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
                      Navigator.push(
                     context,
                     MaterialPageRoute(
                     builder: (context) => EditarPage(),
                     ),
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
