import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nodefirstproj/Screens/waiting_screen.dart';

import '../Widget/doc_builder.dart';
import '../model/player.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  int playersFinished(List<Player> players){
    int pf = 0;
    for(int i = 0; i<players.length; i++){
      if(players[i].hasFinished) pf++;
    }
    return pf;
  }

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
      body: PlayerSnapshots(
        roomId: "GtHieM2C5bA4WCxTUc4y",
        builder: (List<Player> players) {
          int iterator = 0;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < players.length; i++)
                  DocSnapBuilder(
                    docRef: db.doc("/Users/${players[i].userId}"),
                    builder: (
                      BuildContext context,
                      DocumentSnapshot<Map<String, dynamic>> doc,
                    ) {
                      if (players[i].totalTime == 0) {
                        return const SizedBox(width: 0, height: 0);
                      }

                      if(playersFinished(players) <= iterator){
                        iterator = 0;
                      }

                      iterator++;
                      return playerRankRow(
                        rank: iterator,
                        name: doc['Name'],
                        time: players[i].totalTime,
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ignore: camel_case_types
class playerRankRow extends StatelessWidget {
  final int rank;
  final String name;
  final num time;

  const playerRankRow({
    Key? key,
    required this.rank,
    required this.name,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //icon
              if (rank == 1)
                const Icon(Icons.filter_1,
                    color: Color.fromARGB(255, 255, 223, 0)),
              if (rank == 2)
                const Icon(Icons.filter_2,
                    color: Color.fromARGB(255, 168, 169, 173)),
              if (rank == 3)
                const Icon(Icons.filter_3,
                    color: Color.fromARGB(255, 205, 127, 50)),
              if (rank > 3) const SizedBox(width: 20),

              //name
              Text(
                name,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),

              //time
              Row(
                children: [
                  Text(
                    time.toString(),
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  const Text(
                    "''",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
