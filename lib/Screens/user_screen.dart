import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nodefirstproj/Widget/doc_builder.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController controller = TextEditingController();
  FocusNode focusController = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        controller.value = const TextEditingValue();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: DocSnapBuilder(
            docRef: db.doc("/Users/$userId"),
            builder: (
              BuildContext context,
              DocumentSnapshot<Map<String, dynamic>> doc,
            ) {
              return TextField(
                controller: controller,
                focusNode: focusController,
                decoration: InputDecoration(
                  labelText: doc['Name'],
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  String name = doc['Name'].toString();
                  controller.value = TextEditingValue(
                    text: name,
                    selection:
                        TextSelection(baseOffset: 0, extentOffset: name.length),
                  );
                },
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    FirebaseFirestore.instance.doc("/Users/$userId").update(
                      {'Name': value},
                    );
                  }
                  controller.value = const TextEditingValue();
                },
              );
            },
          ),
        ),
        body: DocSnapBuilder(
          docRef: db.doc("/Users/$userId"),
          builder: (
            BuildContext context,
            DocumentSnapshot<Map<String, dynamic>> doc,
          ) {
            final String lastDate = doc['Last Time Play'].toDate().toString();
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 75.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "Sudokus Complete:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Work in progress!", //doc['Sudokus Complete'].toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 150, 190, 210),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 75.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "Wins Online:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Work in progress!", //doc['Sudokus Complete'].toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 150, 190, 210),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 75.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "Win Streak:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Work in progress!", //doc['Sudokus Complete'].toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 150, 190, 210),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 75.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            "Best Time:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Work in progress!", //doc['Sudokus Complete'].toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 150, 190, 210),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 75.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Last Sudoku:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            lastDate.substring(0, 10),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
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
      ),
    );
  }
}
