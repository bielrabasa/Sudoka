import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nodefirstproj/Screens/menu_screen.dart';
import 'package:nodefirstproj/Screens/ranking_screen.dart';
import 'package:nodefirstproj/Screens/sudoku_screen.dart';
import 'package:nodefirstproj/Screens/user_screen.dart';
import 'package:nodefirstproj/Screens/waiting_screen.dart';
import 'package:nodefirstproj/Widget/auth_gate.dart';
import 'package:nodefirstproj/firebase_options.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuScreen(),
        '/user': (context) => const UserScreen(),
        '/waiting': (context) => const WaitingScreen(),
        '/sudoku': (context) => const SudokuScreen(),
        '/ranking': (context) => const RankingScreen(),
      },
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  runApp(
    const AuthGate(app: MyApp()),
  );
}
