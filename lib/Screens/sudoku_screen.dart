import 'package:flutter/material.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

class SudokuScreen extends StatefulWidget {
  const SudokuScreen({
    super.key,
  });

  // String sudoku = SudokuGenerator(emptySquares: 54).newSudoku.toString();

  @override
  State<SudokuScreen> createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  int? selectedIndex;
  String? selectedNumber;

  late String sudoku;
  late String solvedSudoku;
  List<bool> blocked = [];

  List<List<int>> generateSudoku() {
    return SudokuGenerator(emptySquares: 1).newSudoku.toList();
  }

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

  @override
  void initState() {
    //Create puzzle & solved sudoku
    var sudolist = generateSudoku();
    var sudolistsolved = SudokuSolver.solve(sudolist);

    //Store in String variables
    sudoku = listToString(sudolist);
    solvedSudoku = listToString(sudolistsolved);

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
            child: SudokuCell(
              text: "0",
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
              onClick: () {
                if (sudoku == solvedSudoku) {
                  Navigator.pushNamed(context, "/ranking");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class SudokuCell extends StatelessWidget {
  final String text;
  final Color color;
  final void Function() onClick;

  const SudokuCell({
    super.key,
    required this.text,
    required this.color,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Material(
        elevation: 3,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        color: Color.alphaBlend(color, Colors.white),
        child: InkWell(
          onTap: onClick,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
