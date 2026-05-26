import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:lock_app/screens/menu_page.dart';
import 'package:lock_app/screens/perfis_page.dart';
import 'package:lock_app/screens/travar_page.dart';
import 'package:lock_app/screens/controle_page.dart';
import 'package:permission_handler/permission_handler.dart';

class NavigationPage extends StatefulWidget {
   const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
     MenuPage(),
     PerfisPage(), 
     TravarPage(),
     ControlePage(),
  ];

  Future<void> verificarPermissoesDoTutor() async {
    if (!await Permission.systemAlertWindow.isGranted) {
    await Permission.systemAlertWindow.request();
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        
        automaticallyImplyLeading: false,

        title:  Text(
          "LockApp",
          style: TextStyle(
            color: Color.fromARGB(255, 41, 131, 181),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        leading: _currentIndex == 0
         ? IconButton(
          icon:  Icon(Icons.arrow_back, 
          color: Color.fromARGB(255, 41, 131, 181), 
          size: 35),
          onPressed: () {
            
            SystemNavigator.pop();
          },
          
        )
        : null,
        
      ),
      
      
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  Color.fromARGB(255, 4, 54, 79),
        selectedItemColor: Colors.white,
        unselectedItemColor:  Color.fromARGB(255, 41, 131, 181),
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; 
          });
        },
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfis",
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.feed_outlined),
            label: "Apps",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Controles",
          ),
          
        ],
      ),
    );
  }
}