import 'package:cloud_firestore/cloud_firestore.dart';

class Partida {
  DateTime startTime;
  String sudoku, sudokuSolved;
  bool gameOver, isPlaying;

  Partida.fromFirestore(DocumentSnapshot<Map<String, dynamic>> docsnap)
      : startTime = (docsnap['startTime'] as Timestamp).toDate(),
        sudoku = docsnap['Sudoku'],
        sudokuSolved = docsnap['SudokuSolution'],
        gameOver = docsnap['gameOver'],
        isPlaying = docsnap['isPlaying'];
}

Stream<Partida> dbGetPartida(String roomId) async* {
  final db = FirebaseFirestore.instance;
  await for (final doc in db.doc("/TotalRoomsOnline/$roomId").snapshots()) {
    yield Partida.fromFirestore(doc);
  }
}