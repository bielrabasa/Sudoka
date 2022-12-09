import 'package:flutter/material.dart';
import 'package:nodefirstproj/Widget/back_arrow_question.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackArrowQuestion(
            question: "Do you want to exit the queue?",
            onExit: () {
              //TUDU: erase from waiting players
              Navigator.of(context).popUntil((route) => route.isFirst);
            }),
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
