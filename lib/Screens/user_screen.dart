import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    String userId = FirebaseAuth.instance.currentUser!.uid;

    //TUDU: get streambuilder out

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: StreamBuilder(
          stream: db.doc("/Users/$userId").snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return ErrorWidget(snapshot.error.toString());
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final docSnap = snapshot.data!;
            return Text(
              docSnap['Name'],
              style: const TextStyle(
                fontSize: 37,
                fontWeight: FontWeight.bold,
                letterSpacing: 12,
              ),
            );
          },
        ),
      ),
      body: StreamBuilder(
        stream: db.doc("/Users/$userId").snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final doc = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 150, 190, 210),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Sudokus Complete:\t\t"),
                      Text(
                        doc['Sudokus Complete'].toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 150, 190, 210),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Wins Online:\t\t"),
                      Text(
                        doc['Wins Online'].toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 150, 190, 210),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Win Streak:\t\t"),
                      Text(
                        doc['Win Streak'].toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 150, 190, 210),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Better Time:\t\t"),
                      Text(
                        doc['Better Time'].toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 150, 190, 210),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Last Sudoku:\t\t"),
                      Text(
                        doc['Last Time Play'].toDate().toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.logout,
                      ),
                      iconSize: 69,
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
