import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      drawer: Drawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: Text(
                  "Olá,tutor",
                  
                  ))),// Adicionar o nome do usuário no lugar do tutor
              
              
            
              
              
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
    child: Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          IconButton(icon: Icon(Icons.person), onPressed: () {}),
          IconButton(icon: Icon(Icons.feed_outlined), onPressed: () {}),
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
        ],
      ),
    ),
      ),
    
    );
  }
}