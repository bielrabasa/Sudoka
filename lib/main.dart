import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nodefirstproj/firebase_options.dart';
import 'package:nodefirstproj/screens/chat_list_screen.dart';
import 'package:nodefirstproj/screens/chat_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/chats',
      routes: {
        '/chats': (context) => const ChatListScreen(),
        '/messages': (context) => const ChatScreen(),
      },
    );
  }
}