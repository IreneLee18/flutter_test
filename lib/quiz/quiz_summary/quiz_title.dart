import 'package:flutter/material.dart';

class QuizTitle extends StatelessWidget {
  const QuizTitle({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return (Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ));
  }
}
