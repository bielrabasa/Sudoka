import 'package:flutter/material.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "RANKING",
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
