import 'package:flutter/material.dart';
import 'package:test/dice_roller/dice_roller.dart';
// import 'package:test/dice_roller/text.dart';

// StatefulWidget: 當裡面數據有更新時會變化
// StatelessWidget: 靜態的 UI ，裡面數據變化時不會變化
class GradientContainer extends StatelessWidget {
  // GradientContainer({key}) : super(key: key);
  // 上下兩個寫法一樣
  const  GradientContainer({
    required this.colors,
    super.key,
  });
  final List<Color> colors;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      // child: const Center(
      //   child: CustomerText(
      //     text: 'HELLO WORLD!!',
      //   ),
      // ),
      child: const Center(
        child: DiceRoller(),
      ),
    );
  }
}
