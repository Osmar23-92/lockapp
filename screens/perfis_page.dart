import 'package:flutter/material.dart';
import 'package:lock_app/screens/controle_page.dart';
import 'package:lock_app/screens/menu_page.dart';
import 'package:lock_app/screens/travar_page.dart';

class PerfisPage extends StatelessWidget {
  PerfisPage({super.key});

  final List<Map<String, dynamic>> users = [
    {
      "name": "Pedro",
      "color1": Colors.blue,
      "color2": Colors.lightBlueAccent,
      "image": "asset/images/pedro.png",
    },
    {
      "name": "Lucy",
      "color1": Colors.orange,
      "color2": Colors.amber,
      "image": "asset/images/Lucy.jpg"
    },
    {
      "name": "Alice",
      "color1": Colors.pink,
      "color2": Colors.redAccent,
      "image" : "asset/images/Alice.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 4, 54, 79),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 41, 131, 181),
        iconSize: 30,

        type: BottomNavigationBarType.fixed,
        items: [

          BottomNavigationBarItem(
            
           icon: IconButton(
            onPressed: (){
              Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => MenuPage(),
                      ),
                    );
            }, 
            icon: Icon(Icons.home),
            ),
            label: "home",
          ),

          BottomNavigationBarItem(

            icon: IconButton(onPressed: (){
              Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => PerfisPage(),
                      ),
                    );
            }, 
            icon: Icon(Icons.person),
            ),
            label: "Perfis"
          ),

          BottomNavigationBarItem(
            
            icon: IconButton(onPressed: (){
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => TravarPage(),
                  ),
                );
            }, 
            icon: Icon(Icons.feed_outlined),
            ),
            label: "Apps"
          ),
          
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: (){
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => ControlePage(),
                  ),
                );
            }, 
            icon: Icon(Icons.settings),
            ),
            label: "Comntroles"
          ),

        ],
        ),
      
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [
                  user["color1"],
                  user["color2"],
                ],
              ),
              boxShadow: [
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user["name"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),

              Container(
            decoration: BoxDecoration(
              
                color: Colors.white24,
                borderRadius: BorderRadius.circular(15),
              ),

              child: IconButton(
                onPressed: () {},

                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            )
              ],
            ),
          );
        },
      ),
    

    );
  }
}


class InfoItem extends StatelessWidget {
  final String number;
  final String label;

  const InfoItem(this.number, this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

