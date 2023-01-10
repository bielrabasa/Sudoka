import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nodefirstproj/Functions/sudoku_creation.dart';
import 'package:nodefirstproj/Screens/menu_screen.dart';
import 'package:nodefirstproj/Widget/back_arrow_question.dart';
import 'package:nodefirstproj/model/partida.dart';
import 'package:provider/provider.dart';

import '../Widget/doc_builder.dart';
//import 'dart:math';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final partida = context.read<Partida>();
    return Scaffold(
      appBar: AppBar(
          leading: BackArrowQuestion(
              question: "Do you want to exit the queue?",
              onExit: () {
                //erase from waiting players
                FirebaseFirestore.instance
                    .doc(
                        "/TotalRoomsOnline/GtHieM2C5bA4WCxTUc4y/UsersInRoom/$userId")
                    .delete();
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
                    padding: const EdgeInsets.only(left: 150.0),
                    child: Row(
                      children: const [
                        Text(
                          "Room members\t\t",
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
                    DocSnapBuilder(
                      docRef: db.doc("/Users/${docs[i]["userId"]}"),
                      builder: (
                        BuildContext context,
                        DocumentSnapshot<Map<String, dynamic>> doc,
                      ) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              doc['Name'],
                              style: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(height: 40)
                          ],
                        );
                      },
                    ),
                ],
              ),
              MenuButton(
                onClick: () async {
                  SudokuClass sudoku = SudokuClass();
                  await sudoku.pushSudokuToCloud();

                  //is playing to True, read everyone

                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, "/sudokuOnline");
                },
                text: "Start",
                icon: Icons.start,
              ),
            ],
          );
        },
      ),
    );
  }
}
