import 'package:flutter/material.dart';


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

      
      body: ListView.builder(
        padding:  EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return Container(
            margin:  EdgeInsets.only(bottom: 20),
            padding:  EdgeInsets.all(20),
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
                 SizedBox(width: 20),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user["name"],
                        style:  TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                       SizedBox(height: 5),

                       SizedBox(height: 20),
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

                icon:  Icon(
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

   InfoItem(this.number, this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style:  TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style:  TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

