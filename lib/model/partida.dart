
import 'package:cloud_firestore/cloud_firestore.dart';

class Partida {
  DateTime startTime;
  String sudoku, sudokuSolved;
  bool gameOver, isPlaying;

  Partida.fromFirestore(DocumentSnapshot<Map<String, dynamic>> docsnap)
    : startTime = (docsnap['StartTime'] as Timestamp).toDate(),
    sudoku = docsnap['Sudoku'],
    sudokuSolved = docsnap['SudokuSolution'],
    gameOver = docsnap['gameOver'],
    isPlaying = docsnap['isPlaying'];

}