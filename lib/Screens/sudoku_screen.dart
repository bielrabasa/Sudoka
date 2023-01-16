import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nodefirstproj/Functions/sudoku_creation.dart';
import 'package:nodefirstproj/Widget/back_arrow_question.dart';
import 'package:nodefirstproj/Widget/sudoku_cell.dart';

class SudokuScreen extends StatefulWidget {
  final bool online;
  const SudokuScreen({
    super.key,
    required this.online,
  });

  @override
  State<SudokuScreen> createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  SudokuClass sudokuClass = SudokuClass();

  @override
  Widget build(BuildContext context) {
    if (widget.online) {
      //Download sudoku from cloud
      return FutureBuilder(
        future: sudokuClass.getSudokuFromCloud(),
        builder: (context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasError) {
            debugPrint((snapshot.error as Error).stackTrace.toString());
            return ErrorWidget(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return SudokuGame(sudokuClass: sudokuClass, online: true);
        },
      );
    } else {
      //Generate my own sudoku
      sudokuClass.createSudoku();
      return SudokuGame(sudokuClass: sudokuClass, online: false);
    }
  }
}

class SudokuGame extends StatefulWidget {
  final SudokuClass sudokuClass;
  final bool online;

  const SudokuGame({
    super.key,
    required this.sudokuClass,
    required this.online,
  });

  @override
  State<SudokuGame> createState() => _SudokuGameState();
}

class _SudokuGameState extends State<SudokuGame> {
  int? selectedIndex;
  String? selectedNumber;

  late String sudoku;
  List<bool> blocked = [];

  @override
  void initState() {
    sudoku = widget.sudokuClass.sudoku;

    //Generate blocked cells
    for (int i = 0; i < sudoku.length; i++) {
      blocked.add(sudoku[i] != '0');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Resize Sudoku to leave space for everything
    const int nonSudokuSpace = 420;
    double gridSize = MediaQuery.of(context).size.width;
    if (gridSize > MediaQuery.of(context).size.height - nonSudokuSpace) {
      gridSize = MediaQuery.of(context).size.height - nonSudokuSpace;
    }

    //Decoration for grid separator lines
    const BoxDecoration linedecor = BoxDecoration(
      color: Colors.transparent,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 2.0,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackArrowQuestion(
            question: "Do you want to forfeit?",
            onExit: () {
              if (widget.online) {
                String userId = FirebaseAuth.instance.currentUser!.uid;
                FirebaseFirestore.instance
                    .doc(
                        "/TotalRoomsOnline/GtHieM2C5bA4WCxTUc4y/UsersInRoom/$userId")
                    .delete();
              }
              Navigator.of(context).popUntil((route) => route.isFirst);
            }),
        backgroundColor: Colors.black,
        title: const Text(
          "SUDOKA",
          style: TextStyle(
            fontSize: 37,
            fontWeight: FontWeight.bold,
            letterSpacing: 12,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 5),

          Center(
            child: Stack(
              children: [
                for (int i = 0; i < 2; i++)
                  Padding(
                    padding:
                        EdgeInsets.only(left: (gridSize / 3.0 * (i + 1) - 2)),
                    child: Container(
                      width: 5,
                      height: gridSize,
                      decoration: linedecor,
                    ),
                  ),
                for (int i = 0; i < 2; i++)
                  Padding(
                    padding:
                        EdgeInsets.only(top: (gridSize / 3.0 * (i + 1) - 2)),
                    child: Container(
                      width: gridSize,
                      height: 5,
                      decoration: linedecor,
                    ),
                  ),
                SizedBox(
                  width: gridSize,
                  height: gridSize,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 9),
                    itemCount: sudoku.length,
                    itemBuilder: (context, index) {
                      final item = sudoku[index];

                      Color col = (blocked[index])
                          ? Colors.black54
                          : Colors.lightBlueAccent;

                      if (selectedIndex == index) {
                        //Selected
                        col = col.withOpacity(0.6);
                      } else if (selectedNumber == item && item != '0') {
                        //Same number
                        col = col.withOpacity(0.3);
                      } else if (blocked[index]) {
                        col = col.withOpacity(0.1);
                      } else {
                        col = Colors.white;
                      }

                      return SudokuCell(
                        text: (item != '0') ? item : "",
                        color: col,
                        onClick: () {
                          setState(() {
                            if (selectedIndex == index) {
                              selectedIndex = null;
                              selectedNumber = null;
                            } else {
                              selectedIndex = index;
                              selectedNumber = item;
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          //Erase Button
          SizedBox(
            height: 50,
            width: 200,
            child: SudokuCellIcon(
              icon: Icons.keyboard_backspace,
              color: Colors.deepPurple[200]!,
              onClick: () {
                if (selectedIndex != null && !blocked[selectedIndex!]) {
                  setState(() {
                    sudoku = sudoku.replaceRange(
                      selectedIndex!,
                      selectedIndex! + 1,
                      '0',
                    );
                    selectedNumber = '0';
                  });
                }
              },
            ),
          ),

          //NumPad
          SizedBox(
            height: 200,
            width: 200,
            child: Center(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 9,
                itemBuilder: (context, index) {
                  final num = index + 1;
                  return SudokuCell(
                    text: num.toString(),
                    color: Colors.deepPurple[100]!,
                    onClick: () {
                      if (selectedIndex != null && !blocked[selectedIndex!]) {
                        setState(() {
                          sudoku = sudoku.replaceRange(
                            selectedIndex!,
                            selectedIndex! + 1,
                            num.toString(),
                          );
                          selectedNumber = num.toString();
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          //Submit button
          SizedBox(
            width: 100,
            height: 50,
            child: SudokuCell(
              color: Colors.deepPurple[200]!,
              text: "Submit",
              onClick: () async {
                if (sudoku == widget.sudokuClass.sudokuSolved) {
                  //VICTORY
                  if (widget.online) {
                    String userId = FirebaseAuth.instance.currentUser!.uid;

                    var room = await FirebaseFirestore.instance
                        .doc("/TotalRoomsOnline/GtHieM2C5bA4WCxTUc4y")
                        .get();

                    FirebaseFirestore.instance
                        .doc(
                            "/TotalRoomsOnline/GtHieM2C5bA4WCxTUc4y/UsersInRoom/$userId")
                        .update({
                      'percentage': 0,
                      'hasFinished': true,
                      'totalTime': Timestamp.now().seconds -
                          (room['startTime'] as Timestamp).seconds,
                    });
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushNamed(context, "/ranking");
                  } else {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
