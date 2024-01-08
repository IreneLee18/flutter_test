import 'package:flutter/material.dart';

class QuizText extends StatelessWidget {
  const QuizText({required this.text, required this.color, super.key});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return (Text(
      text,
      style: TextStyle(color: color),
    ));
  }
}
