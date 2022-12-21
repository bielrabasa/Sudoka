import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

class SudokuClass {
  String sudoku = "";
  String sudokuSolved = "";

  SudokuClass();

  //NORMALIZE SUDOKUS
  String listToString(List<List<int>> list) {
    String s = "";

    //Clean strings
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list[i].length; j++) {
        s += list[i][j].toString();
      }
    }

    return s;
  }

  //GENERATE SUDOKUS
  void createSudoku() {
    var sudolist = SudokuGenerator(emptySquares: 1).newSudoku.toList();
    var sudolistsolved = SudokuSolver.solve(sudolist);

    //Store in String variables
    sudoku = listToString(sudolist);
    sudokuSolved = listToString(sudolistsolved);
  }

  Future<void> pushSudokuToCloud() async {
    createSudoku();

    final instance = FirebaseFirestore.instance;

    await instance.doc("TotalRoomsOnline/GtHieM2C5bA4WCxTUc4y").set(
      {
        'Sudoku': sudoku,
        'SudokuSolution': sudokuSolved,
      },
    );
  }

  Future<void> getSudokuFromCloud() async {
    final instance = FirebaseFirestore.instance;
    final docSnap =
        await instance.doc("TotalRoomsOnline/GtHieM2C5bA4WCxTUc4y").get();
    final data = docSnap.data();
    if (data == null) {
      throw "getSudokuFromCloud: No hi ha dades";
    }
    sudoku = data['Sudoku'];
    sudokuSolved = data['SudokuSolved'];
  }
}
