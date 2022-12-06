import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:nodefirstproj/firebase_options.dart';

import 'package:nodefirstproj/Screens/menuScreen.dart';
import 'package:nodefirstproj/Screens/userScreen.dart';
import 'package:nodefirstproj/Screens/waitingScreen.dart';
import 'package:nodefirstproj/Screens/sudokuScreen.dart';
import 'package:nodefirstproj/Screens/rankingScreen.dart';

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
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => const MenuScreen(),
        '/userInfo': (context) => const UserScreen(),
        '/waiting': (context) => const WaitingScreen(),
        '/sudoku': (context) => const SudokuScreen(),
        '/ranking': (context) => const RankingScreen(),
      },
    );
  }
}