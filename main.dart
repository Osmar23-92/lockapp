import 'package:flutter/material.dart';
import 'package:lock_app/screens/login_page.dart';

void main(){
  runApp(LockApp());

}
class LockApp extends StatelessWidget {
  const LockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
     
    );
  }
}