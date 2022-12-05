import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatTitle extends StatelessWidget {
  const ChatTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return StreamBuilder(
      stream: db.doc("/chats/CLbH4zozZsjte8VmKikw").snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
      ) {
        // 1. Mirar si ha sorgit un error
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error.toString());
        }

        // 2. Mirar si tenim dades
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final docSnap = snapshot.data!;
        return Text(docSnap['title']);
      },
    );
  }
}