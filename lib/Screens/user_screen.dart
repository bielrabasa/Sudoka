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
              //TUDU: search current User, not first
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
          return Column(
            children: [
              Text(
                doc['Sudokus Complete'].toString(),
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                doc['Wins Online'].toString(),
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                doc['Win Streak'].toString(),
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                doc['Better Time'].toString(),
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                doc['Last Time Play'].toDate().toString(),
                style: const TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
