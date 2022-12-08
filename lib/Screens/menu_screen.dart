import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
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
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/user");
                  setState(() {});
                },
                icon: const Icon(
                  Icons.account_box,
                  color: Colors.white,
                  size: 35,
                ))
          ],
        ),
        body: const LogedUser());
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
              setState(() {});
            },
            child: const Text(
              "Play Online",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/sudoku");
              setState(() {});
            },
            child: const Text(
              "Play Offline",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          )
        ],
      ),
    );
  }
}
