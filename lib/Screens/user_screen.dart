import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

    //TUDU: get streambuilder out

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        controller.value = const TextEditingValue();
      },
      child: Scaffold(
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
              return TextField(
                controller: controller,
                focusNode: focusController,
                decoration: InputDecoration(
                  labelText: docSnap['Name'],
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 12,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () {
                  String name = docSnap['Name'].toString();
                  controller.value = TextEditingValue(
                    text: name,
                    selection: TextSelection(
                        baseOffset: 0, extentOffset: name.length),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 75.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Sudokus Complete:"),
                          Text(
                            doc['Sudokus Complete'].toString(),
                            style: const TextStyle(fontSize: 16),
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
                          const Text("Wins Online:"),
                          Text(
                            doc['Wins Online'].toString(),
                            style: const TextStyle(fontSize: 16),
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
                          const Text("Win Streak:"),
                          Text(
                            doc['Win Streak'].toString(),
                            style: const TextStyle(fontSize: 16),
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
                          const Text("Better Time:"),
                          Text(
                            doc['Better Time'].toString(),
                            style: const TextStyle(fontSize: 16),
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
                          const Text("Last Sudoku:"),
                          Text(
                            doc['Last Time Play'].toDate().toString(),
                            style: const TextStyle(fontSize: 16),
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
