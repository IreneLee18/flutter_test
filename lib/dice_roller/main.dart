import 'package:flutter/material.dart';
import 'package:test/dice_roller/gradient_container.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      // backgroundColor: Colors.lightBlue,
      body: GradientContainer(
        colors: [
          Colors.pink,
          Color.fromARGB(255, 230, 111, 151),
          Color.fromARGB(255, 250, 174, 199),
        ],
      ),
    ),
  ));
}
