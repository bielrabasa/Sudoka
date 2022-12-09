import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null &&
          (DateTime.now().minute == user.metadata.creationTime!.minute)) {
        FirebaseFirestore.instance.doc("/Users/$userId").set({
          'Better Time': '0.0',
          'Name': 'NewUser',
          'Sudokus Complete': '0',
          'Win Streak': '0',
          'Wins Online': '0',
          'Last Time Play': DateTime.now().toUtc()
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "SUDOKA",
          style: TextStyle(
            fontSize: 37,
            fontWeight: FontWeight.bold,
            letterSpacing: 12,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/user");
              },
              icon: const Icon(
                Icons.account_box,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: const LogedUser(),
    );
  }
}

class LogedUser extends StatefulWidget {
  const LogedUser({
    Key? key,
  }) : super(key: key);

  @override
  State<LogedUser> createState() => _LogedUserState();
}

class _LogedUserState extends State<LogedUser> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/waiting");
            },
            child: const Text(
              "Play Online",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/sudoku");
            },
            child: const Text(
              "Play Offline",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
