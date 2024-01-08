import 'package:flutter/material.dart';

class SpaceBox extends StatelessWidget {
  const SpaceBox({required this.height, super.key});
  final double height;

  @override
  Widget build(context) {
    return (SizedBox(
      height: height,
    ));
  }
}
