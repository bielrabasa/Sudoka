import 'package:flutter/material.dart';

class BackArrowQuestion extends StatelessWidget {
  final void Function() onExit;
  final String question;

  const BackArrowQuestion({
    Key? key,
    required this.question,
    required this.onExit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(question),
          actions: [
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const SizedBox(
                width: 50,
                height: 40,
                child: Center(child: Text("NO")),
              ),
            ),
            InkWell(
              onTap: onExit,
              child: const SizedBox(
                width: 50,
                height: 40,
                child: Center(child: Text("YES")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
