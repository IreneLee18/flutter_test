import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  const QuizButton({required this.text, required this.onClick, super.key});
  final String text;
  final void Function() onClick;

  @override
  Widget build(context) {
    return (ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        // minimumSize: const Size(300, 40),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 207, 102, 10),
        textStyle: const TextStyle(
          fontSize: 16,
        ),
      ),
      onPressed: onClick,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    ));
  }
}
