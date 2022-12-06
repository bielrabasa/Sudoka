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

  String sudoku = SudokuGenerator(emptySquares: 50)
      .newSudoku
      .toString()
      .replaceAll('[', '')
      .replaceAll(']', '')
      .replaceAll(',', '')
      .replaceAll(' ', '');

  /*String generateSudoku() {
    var l = SudokuGenerator(emptySquares: 54).newSudoku.toList();
    String s = "";

    for (int i = 0; i < l.length; i++) {
      for (int j = 0; j < l[i].length; j++) {
        s += l[i][j].toString();
      }
    }

    return s;
  }*/

  @override
  Widget build(BuildContext context) {
    double gridSize = MediaQuery.of(context).size.width;
    if(gridSize > MediaQuery.of(context).size.height - 350){
      gridSize = MediaQuery.of(context).size.height - 350;
    }
    
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
            child: SizedBox(
              width: gridSize,
              height: gridSize,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 9),
                itemCount: sudoku.length,
                itemBuilder: (context, index) {
                  final item = sudoku[index];
                  return SudokuCell(
                    text: (item != '0') ? item : "",
                    color: ((selectedIndex == index)
                        ? Colors.blue[200]
                        : ((selectedNumber == item && item != '0')
                            ? Colors.blue[50]
                            : Colors.white))!,
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
          ),
          //const SizedBox(height: 30),
          SizedBox(
            height: 50,
            width: 200,
            child: SudokuCell(
              text: "<--",
              color: Colors.green,
              onClick: () {
                if (selectedIndex != null) {
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
                    color: Colors.green,
                    onClick: () {
                      if (selectedIndex != null) {
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
    return Card(
      color: color,
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
    );
  }
}