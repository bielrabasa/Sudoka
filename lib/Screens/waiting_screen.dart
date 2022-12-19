import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nodefirstproj/Screens/menu_screen.dart';
import 'package:nodefirstproj/Widget/back_arrow_question.dart';
//import 'dart:math';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
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
      body: StreamBuilder(
          stream: db
              .collection("/TotalRoomsOnline/GtHieM2C5bA4WCxTUc4y/UsersInRoom")
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return ErrorWidget(snapshot.error.toString());
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final querySnap = snapshot.data!;
            final docs = querySnap.docs;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 50),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 150.0),
                      child: Row(
                        children: const [
                          Text(
                            "Room X",
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    for (var i = 0; i < docs.length; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("-\t"),
                          Text(
                            docs[i]["userName"],
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("-\t"),
                        Text(
                          "...",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                MenuButton(
                  onClick: (() {}),
                  text: "Start",
                  icon: Icons.start,
                ),
              ],
            );
          }),
    );
  }
}
