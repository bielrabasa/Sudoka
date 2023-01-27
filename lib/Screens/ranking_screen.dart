import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nodefirstproj/Screens/waiting_screen.dart';

import '../Widget/doc_builder.dart';
import '../model/player.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0),
        child: PlayerSnapshots(
          roomId: "GtHieM2C5bA4WCxTUc4y",
          builder: (List<Player> players) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          for (var i = 0; i < players.length; i++)
                            DocSnapBuilder(
                              docRef: db.doc("/Users/${players[i].userId}"),
                              builder: (
                                BuildContext context,
                                DocumentSnapshot<Map<String, dynamic>> doc,
                              ) {
                                return Column(
                                  children: [
                                    Text(
                                      doc['Name'],
                                      style: const TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                  ],
                                );
                              },
                            ),
                        ],
                      ),
                      //const SizedBox(width: 100),
                      Column(
                        children: [
                          for (var i = 0; i < players.length; i++)
                            DocSnapBuilder(
                              docRef: db.doc("/Users/${players[i].userId}"),
                              builder: (
                                BuildContext context,
                                DocumentSnapshot<Map<String, dynamic>> doc,
                              ) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          players[i].totalTime.toString(),
                                          style: const TextStyle(
                                            fontSize: 25,
                                          ),
                                        ),
                                        // ignore: prefer_const_constructors
                                        Text(
                                          "''",
                                          style: const TextStyle(
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 50),
                                  ],
                                );
                              },
                            ),
                        ],
                      )
                    ],
                  ),
                  /*Column(
                    children: [
                      for (var i = 0; i < players.length; i++)
                        DocSnapBuilder(
                          docRef: db.doc("/Users/${players[i].userId}"),
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
                                const SizedBox(width: 100),
                                Text(
                                  players[i].totalTime.toString(),
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                // ignore: prefer_const_constructors
                                Text(
                                  " Seconds",
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                    ],
                  ),*/
                  const SizedBox(height: 50),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
