import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  const StyledText({required this.text, super.key});

  final String text;

  @override
  Widget build(context) {
    return (Text(
      text,
      // 使用 google font 字體
      style: GoogleFonts.lato(
        fontSize: 24,
        color: Color.fromARGB(255, 255, 230, 219),
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ));
  }
}
