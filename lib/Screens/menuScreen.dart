import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isUser = true;

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
            (isUser)
                ? const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.account_box,
                      color: Colors.white,
                      size: 35,
                    ))
                : Container(),
          ],
        ),
        body: (isUser) ? const LogedUser() : const LogInUser());
  }
}

class LogInUser extends StatelessWidget {
  const LogInUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 350,
            height: 200,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(35))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("User"),
                Container(
                  width: 200,
                  height: 25,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(35))),
                ),
                const Text("Password"),
                Container(
                  width: 200,
                  height: 25,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(35))),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              ElevatedButton(onPressed: null, child: Text("Log In")),
              ElevatedButton(onPressed: null, child: Text("New user"))
            ],
          )
        ],
      ),
    );
  }
}

class LogedUser extends StatelessWidget {
  const LogedUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          ElevatedButton(
            onPressed: null,
            child: Text(
              "Play Online",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: null,
            child: Text(
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
