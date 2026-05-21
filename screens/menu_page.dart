import 'package:flutter/material.dart';
import 'package:lock_app/screens/controle_page.dart';
import 'package:lock_app/screens/perfis_page.dart';
import 'package:lock_app/screens/travar_page.dart';
import 'package:lock_app/services/user_data.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {

    final String nomeExibicao = (UserData.nomeUsuario != null && UserData.nomeUsuario!.isNotEmpty)
    ? UserData.nomeUsuario!
    : "tutor" ;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            
            style: TextStyle(
              color: const Color.fromARGB(255, 41, 131, 181),
              fontSize: 30, 
              fontWeight: FontWeight.bold,
            ),
            "LockApp",
            
            ),
        ),
        iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 41, 131, 181),
          size: 35,
        ),
      ),
      
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,

            children: [

            SizedBox(
              
              width: double.infinity,
              child: Text(
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 4, 54, 79),
                ),
                "Olá, $nomeExibicao!",
                
                ),
            ),
            
            
              
              
            Row(
              spacing: 7,
              children: [
                SizedBox(
                  height: 50,
                  child: Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                       textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                       ), 
                       foregroundColor: const Color.fromARGB(255, 41, 131, 181),
                      ),
                      onPressed: (){},
                       child: Text(
                        "Controle sensorial",
                        ),
                      ),
                    ),
                ),
                SizedBox(
                  height: 50,
                  child: Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        foregroundColor: const Color.fromARGB(255, 41, 131, 181),
                      ),
                      onPressed: (){},
                       child: Text(
                        "Modo guiado",
                        ),
                      ),
                  ),
                ),
              ],
            ),
            
            Row(
              spacing: 7,
              children: [
                SizedBox(
                  height: 50,
                  child: Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        foregroundColor: const Color.fromARGB(255, 41, 131, 181),
                      ),
                      onPressed: (){},
                       child: Text(
                        "Apps restritos",
                        ),
                      ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        foregroundColor: const Color.fromARGB(255, 41, 131, 181),
                      ),
                      onPressed: (){},
                       child: Text(
                        "Sincronização",
                        ),
                      ),
                  ),
                ),
              ],
            ),
          ],
          ),
        ),
      ),
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