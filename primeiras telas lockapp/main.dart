import 'package:flutter/material.dart';
String? usuarioRegistrado;
String? senhaRegistrada; 

void main(){
  runApp(Lockapp());
}

class Lockapp extends StatelessWidget {
   Lockapp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: TelaLogin (),
    );
  }
}

class TelaLogin extends StatefulWidget {
  TelaLogin({super.key});
@override
  State<TelaLogin> createState() => _TelaLoginState();
}
class _TelaLoginState extends State<TelaLogin> {
  
  bool cardCadastro = false;

  final TextEditingController _controllerUsuario = TextEditingController();
final TextEditingController _controllerSenha = TextEditingController();

   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 43, 52),
      body: Center( 
        
        child: SingleChildScrollView( 
          child: Card( 
            elevation: 10,
            color: const Color.fromARGB(255, 139, 224, 252),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("asset/images/iconlock.png", width: 80),
                  const SizedBox(height: 20),
                  
                  Text(
                    cardCadastro ? "CADASTRO" : "LOGIN",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: cardCadastro ? const Color.fromARGB(255, 8, 43, 52) : const Color.fromARGB(255, 8, 43, 52),
                    ),
                  ),
                  const SizedBox(height: 30),

                  TextField(
                    controller: _controllerUsuario,
                    decoration: InputDecoration(
                      labelText: cardCadastro ? "Criar um Usuário:" : "Usuário:",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo de Senha
                  TextField(
                    controller: _controllerSenha,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: cardCadastro ? "Crie uma Senha:" : "Senha:",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botão de Ação Principal (Entrar ou Cadastrar)
                  ElevatedButton(
                    onPressed: () {
                      if (cardCadastro) {
                        // Lógica de Salvar Cadastro
                        setState(() {
                          usuarioRegistrado = _controllerUsuario.text;
                          senhaRegistrada = _controllerSenha.text;
                          cardCadastro = false; // Volta para o login após cadastrar
                        });
                        print("Registrado: $usuarioRegistrado");
                      } else {
                        // Lógica de Login
                        if (_controllerUsuario.text == usuarioRegistrado &&
                            _controllerSenha.text == senhaRegistrada) {
                          print("Login Sucesso!");

                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TelaMenu()),
                            );

                        } else {
                          print("Usuário ou senha incorretos");
                        }
                      }
                    },
                    child: Text(cardCadastro ? "Finalizar Cadastro" : "Entrar"),
                  ),

                  // O alternador de telas (Troca o valor de cardCadastro) 
                  TextButton(
                    onPressed: () {
                      setState(() {
                        cardCadastro = !cardCadastro;
                      });
                    },
                    child: Text(cardCadastro ? "Já tenho conta? Login" : "Não tem conta? Cadastre-se"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class TelaCadastro extends StatelessWidget {

final TextEditingController _controllerEmailCadastro = TextEditingController();
final TextEditingController _controllerSenhaCadastro = TextEditingController();
   TelaCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(150, 125, 221, 253),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 100,
        ),
        child: Column(
          spacing: 30,
          children: [
        
        Image.asset(
          "asset/images/iconlock.png",
                  width: 100,
                  ),
        
        Text("Cadastro",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 120, 0, 0),
        ),
        ),
        
        TextField(
          controller: _controllerEmailCadastro,
          decoration: InputDecoration(
           labelText: "E-mail/Usuário:",
            border: OutlineInputBorder()),
          ),
        
        TextField(
          controller:_controllerSenhaCadastro,
         decoration: InputDecoration(
           labelText: "Senha:",
            border: OutlineInputBorder()), 
        ),
        
        
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [

        TextButton(
          onPressed: (){
            usuarioRegistrado = _controllerEmailCadastro.text;
            senhaRegistrada = _controllerSenhaCadastro.text;
            Navigator.pop(context);
            print("Usuário cadastrado com sucesso : $usuarioRegistrado");
          },
           child: 
           Text("Cadastrar",
           style: TextStyle(
            color: const Color.fromARGB(255, 241, 48, 9)),
            ),

           ),
           SizedBox(width: 20,),
        
        

        ]
         
        ),
        
          ],
        
          
        ),
      ),
    );
  }
}

class TelaMenu extends StatelessWidget {
  const TelaMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 79, 152, 248),
      appBar: AppBar(
        title: const Text("Aplicativo")),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  
                  color: Color.fromARGB(255, 32, 221, 32),
                
                ),
                
              child: Text("Menu"),
              
              ),
              SizedBox(
                width: 15,
              ),

              ListTile(
                title: const Text("Item 1"),
              ),
              ListTile(
                title: const Text("Item 2"),
              )
            ],
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 30,
        ),
        child: Column(
          spacing: 30,
          children: [
        
        Image.asset(
          "asset/images/cadastro.png",
                  width: 80,
                  ),
        
        Text("Cadastro",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 120, 0, 0),
        ),
        ),
        
        TextField(
          decoration: InputDecoration(
           labelText: "Nome:",
            border: OutlineInputBorder()),
          ),
        
        TextField(
         decoration: InputDecoration(
           labelText: "CPF:",
            border: OutlineInputBorder()), 
        ),
        
        TextField(
          decoration: InputDecoration(
           labelText: "Endereço:",
            border: OutlineInputBorder()),
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [

        TextButton(
          onPressed: (){},
           child: 
           Text("Cadastrar",
           style: TextStyle(
            color: Colors.greenAccent),
            ),

           ),
           SizedBox(width: 20,),
        
        TextButton(
          onPressed: (){},

            child: 
            Text("Limpar",
            
            ),
            ),

        ]
         
        ),
        
          ],
        
          
        ),
      ),
      
     );
  }
}