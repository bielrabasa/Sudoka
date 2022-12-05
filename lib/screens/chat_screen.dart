import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatId = ModalRoute.of(context)!.settings.arguments as String;
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Això és un xat FANCY"),
      ),
      body: StreamBuilder(
        stream:
            db.collection("/chats/$chatId/messages").snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
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
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 150),
                child: Container(
                  color: Color.fromARGB(255, 88, 184, 117),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    doc['text'],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
