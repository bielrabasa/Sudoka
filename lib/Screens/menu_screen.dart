import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          'Better Time': 0.0,
          'Name': 'NewUser',
          'Sudokus Complete': 0,
          'Win Streak': 0,
          'Wins Online': 0,
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
    String userId = FirebaseAuth.instance.currentUser!.uid;
    //final partida = context.read
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MenuButton(
            onClick: () async {
              bool isPlaying = false;
              final navigator = Navigator.of(context);

              var docSnapshot = await FirebaseFirestore.instance
                  .doc("/TotalRoomsOnline/GtHieM2C5bA4WCxTUc4y")
                  .get();

              isPlaying = docSnapshot['isPlaying'];

              if (!isPlaying) {
                if (docSnapshot['isWaiting'] == false) {
                  //Delete all users
                  final collection = await FirebaseFirestore.instance.collection("/TotalRoomsOnline/GtHieM2C5bA4WCxTUc4y/UsersInRoom").get();
                  for (final user in collection.docs){
                      user.reference.delete();
                  }

                  //Set isWaiting
                  FirebaseFirestore.instance
                      .doc("/TotalRoomsOnline/GtHieM2C5bA4WCxTUc4y")
                      .update({'isWaiting': true});
                }

                //Add player to list
                FirebaseFirestore.instance
                    .doc(
                        "/TotalRoomsOnline/GtHieM2C5bA4WCxTUc4y/UsersInRoom/$userId")
                    .set(
                  {
                    'totalTime': 0,
                    'percentage': 0,
                    'hasFinished': false,
                  },
                );

                navigator.pushNamed("/waiting");
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Warning'),
                      content: const Text('The game is already start'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('CONFIRM'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            text: "Play Online",
            icon: Icons.wifi,
          ),
          const SizedBox(height: 40),
          MenuButton(
            onClick: () {
              Navigator.pushNamed(context, "/sudokuOffline");
            },
            text: "Play Offline",
            icon: Icons.home,
          ),
          const SizedBox(height: 40),
          MenuButton(
            onClick: () {
              Navigator.pushNamed(context, "/ranking");
            },
            text: "Ranking",
            icon: Icons.leaderboard,
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final void Function() onClick;
  final String text;
  final IconData icon;

  const MenuButton({
    Key? key,
    required this.onClick,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            Icon(
              icon,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
