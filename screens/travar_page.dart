import 'package:flutter/material.dart';
import 'package:lock_app/screens/controle_page.dart';
import 'package:lock_app/screens/menu_page.dart';
import 'package:lock_app/screens/perfis_page.dart';

class TravarPage extends StatelessWidget {
  const TravarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
    shape: CircularNotchedRectangle(), // Recorte para o botão flutuante, se houver
    color: Colors.blue,
    child: SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: Icon(Icons.home), onPressed: () {
            Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => MenuPage(),
                      ),
                    );
          }),

          IconButton(icon: Icon(Icons.person), onPressed: () {
            Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => PerfisPage(),
                      ),
                    );
          }),

          IconButton(icon: Icon(Icons.feed_outlined), onPressed: () {
            Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => TravarPage(),
                      ),
                    );
          }),

          IconButton(icon: Icon(Icons.settings), onPressed: () {
            Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => ControlePage(),
                      ),
                    );
          }),

        ],
      ),
    ),
      ),
    );
  }
}