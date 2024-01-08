import 'package:flutter/material.dart';

class QuizIndex extends StatelessWidget {
  const QuizIndex({required this.num, required this.isCorrect, super.key});
  final int num;
  final bool isCorrect;

  @override
  // 數字置中：外框需要貼齊頂部，並且將數字置中
  // 寫法一：我自己寫的
  // SizedBox：設定寬高
  // Center：整體垂直置中
  // textAlign：文字平行置中

  // Widget build(BuildContext context) {
  //   return (Container(
  //     margin: const EdgeInsets.only(right: 20),
  //     child: DecoratedBox(
  //       decoration: BoxDecoration(
  //         color: isCorrect
  //             ? Color.fromARGB(130, 0, 139, 190)
  //             : Color.fromARGB(185, 248, 59, 1),
  //         shape: BoxShape.circle,
  //       ),
  //       child: SizedBox(
  //         height: 30,
  //         width: 30,
  //         child: Center(
  //           child: Text(
  //             num.toString(),
  //             style: const TextStyle(
  //               fontSize: 18,
  //               color: Color.fromARGB(255, 255, 255, 255),
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //       ),
  //     ),
  //   ));
  // }
  
  // 寫法二：老師寫的
  // Container：設定寬高＋「alignment：整體垂直平行置中」
  Widget build(BuildContext context) {
    return (Container(
      margin: const EdgeInsets.only(right: 20),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isCorrect
              ? Color.fromARGB(130, 0, 139, 190)
              : Color.fromARGB(185, 248, 59, 1),
          shape: BoxShape.circle,
        ),
        child: Container(
          height: 30,
          width: 30,
          alignment: Alignment.center,
          child: Text(
            num.toString(),
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
    ));
  }
}
