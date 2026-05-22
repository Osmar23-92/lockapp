import 'package:flutter/material.dart';

class TravarPage extends StatelessWidget {
  const TravarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Tela de Apps", 
          style: TextStyle(
            fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
