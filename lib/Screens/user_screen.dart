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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: StreamBuilder(
          stream: db.collection("/Users").snapshots(),
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
            return Text(
              //TUDU: search current User, not first
              docs.first['User'],
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
        stream: db.collection("/Users").snapshots(),
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
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final Timestamp t = doc['Last Time Play'];
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
                    t.toDate().toString(),
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
          );
        },
      ),
    );
  }
}
