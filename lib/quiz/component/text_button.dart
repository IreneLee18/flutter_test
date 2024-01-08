import 'package:flutter/material.dart';

class QuizTextButton extends StatefulWidget {
  const QuizTextButton(
      {required this.icon,
      required this.text,
      required this.onClick,
      super.key});
  final void Function() onClick;
  final String text;
  final IconData icon;

  @override
  State<QuizTextButton> createState() {
    return _QuizTextButtonState();
  }
}

class _QuizTextButtonState extends State<QuizTextButton> {
  @override
  Widget build(BuildContext context) {
    return (TextButton.icon(
      style: TextButton.styleFrom(
        // 文字顏色
        foregroundColor: Color.fromARGB(255, 215, 97, 0),
        textStyle: const TextStyle(
          fontSize: 18,
        ),
      ),
      onPressed: () {
        widget.onClick();
      },
      icon: Icon(widget.icon),
      label: Text(widget.text),
    ));
  }
}
