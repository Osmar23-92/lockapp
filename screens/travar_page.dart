import 'package:flutter/material.dart';
import 'package:lock_app/screens/controle_page.dart';
import 'package:lock_app/screens/menu_page.dart';
import 'package:lock_app/screens/perfis_page.dart';

class TravarPage extends StatelessWidget {
  const TravarPage({super.key});

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

      body: Center(
        child: Column(
          children: [
            
          ],
        ),
      ),


      
    );
  }
}