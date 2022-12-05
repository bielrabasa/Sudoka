import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return StreamBuilder(
      stream: db
          .collection("/chats")
          .orderBy("createdAt", descending: false)
          .snapshots(),
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
            return ListTile(
              title: Text(doc['title']),
              subtitle: Text(
                  (doc['createdAt'] as Timestamp).toDate().toIso8601String()),
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/messages',
                  arguments: doc.id,
                );
              },
            );
          },
        );
      },
    );
  }
}
