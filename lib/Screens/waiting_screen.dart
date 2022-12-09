import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:nodefirstproj/Widget/back_arrow_question.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime _timer = DateTime.now();
    return Scaffold(
      appBar: AppBar(
          leading: BackArrowQuestion(
              question: "Do you want to exit the queue?",
              onExit: () {
                //TUDU: erase from waiting players
                Navigator.of(context).popUntil((route) => route.isFirst);
              }),
          backgroundColor: Colors.black,
          title: Row(
            children: [
              const Text(
                "WAITING",
                style: TextStyle(
                  fontSize: 37,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 12,
                ),
              ),
              AnimatedTextKit(animatedTexts: [
                TyperAnimatedText("...",
                    textStyle: const TextStyle(
                        fontSize: 37, fontWeight: FontWeight.bold),
                    speed: const Duration(milliseconds: 500)),
              ], repeatForever: true, pause: const Duration(milliseconds: 50))
            ],
          )),
      body: null,
    );
  }
}
