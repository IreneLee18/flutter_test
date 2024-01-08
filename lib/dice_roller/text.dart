import 'package:flutter/material.dart';

class CustomerText extends StatelessWidget {
  final String text;
  const CustomerText({
    super.key,
    required this.text,
  });

  @override
  Widget build(context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 42,
      ),
    );
  }
}
