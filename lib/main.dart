import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nodefirstproj/Screens/menu_screen.dart';
import 'package:nodefirstproj/Screens/ranking_screen.dart';
import 'package:nodefirstproj/Screens/sudoku_screen.dart';
import 'package:nodefirstproj/Screens/user_screen.dart';
import 'package:nodefirstproj/Screens/waiting_screen.dart';
import 'package:nodefirstproj/Widget/auth_gate.dart';
import 'package:nodefirstproj/firebase_options.dart';
import 'package:nodefirstproj/model/partida.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return StreamBuilder(
      stream: db.doc("/TotalRoomsOnline/GtHieM2C5bA4WCxTUc4y").snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final docSnap = snapshot.data!;
        final partida = Partida.fromFirestore(docSnap);
        return Provider<Partida>.value(
          value: partida,
          child: MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => const MenuScreen(),
              '/user': (context) => const UserScreen(),
              '/waiting': (context) => const WaitingScreen(),
              '/sudokuOnline': (context) => const SudokuScreen(online: true),
              '/sudokuOffline': (context) => const SudokuScreen(online: false),
              '/ranking': (context) => const RankingScreen(),
            },
          ),
        );
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
