import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DocSnapBuilder extends StatelessWidget {
  final DocumentReference<Map<String, dynamic>> docRef;
  final Widget Function(BuildContext, DocumentSnapshot<Map<String, dynamic>>)
      builder;

  const DocSnapBuilder({
    super.key,
    required this.docRef,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: docRef.snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return builder(context, snapshot.data!);
      },
    );
  }
}
