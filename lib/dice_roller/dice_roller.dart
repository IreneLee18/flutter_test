import 'dart:math';

import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

final random = Random();

class _DiceRollerState extends State<DiceRoller> {
  String image = 'assets/images/dice-2.png';

  void rollDice() {
    setState(() {
      // 需要將需要變更的資料放在 setState 裡面，才可以更新畫面
      int intValue = random.nextInt(6) + 1;
      image = 'assets/images/dice-$intValue.png';
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          image,
          width: 200,
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: rollDice,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 20,
              left: 20,
            ),
            foregroundColor: Colors.pink[400],
            textStyle: const TextStyle(
              fontSize: 20,
            ),
          ),
          child: const Text('Roll Dice'),
        )
      ],
    );
  }
}
