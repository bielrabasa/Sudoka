import 'package:flutter/material.dart';

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

class SudokuCellIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final void Function() onClick;

  const SudokuCellIcon({
    super.key,
    required this.icon,
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
            child: Icon(
              icon,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
