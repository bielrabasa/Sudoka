import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nodefirstproj/Screens/menu_screen.dart';
import 'package:nodefirstproj/Screens/ranking_screen.dart';
import 'package:nodefirstproj/Screens/sudoku_screen.dart';
import 'package:nodefirstproj/Screens/user_screen.dart';
import 'package:nodefirstproj/Screens/waiting_screen.dart';
import 'package:nodefirstproj/Widget/AuthGate.dart';
import 'package:nodefirstproj/firebase_options.dart';

/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => const MenuScreen(),
        '/Users': (context) => const UserScreen(),
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
