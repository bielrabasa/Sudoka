import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "WAITING...",
          style: TextStyle(
            fontSize: 37,
            fontWeight: FontWeight.bold,
            letterSpacing: 12,
          ),
        ),
      ),
      body: null,
    );
  }
}