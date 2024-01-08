import 'package:flutter/material.dart';
import 'package:test/quiz/component/size_box.dart';
import 'package:test/quiz/component/text_button.dart';
import 'package:test/quiz/component/text.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({required this.handleStartQuiz, super.key});
  final void Function() handleStartQuiz;

  @override
  Widget build(context) {
    return (Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 透明照片有兩種寫法：
          // 寫法一：
          // Opacity(
          //   opacity: 0.7,
          //   child: Image.asset(
          //     'assets/images/quiz-logo.png',
          //     width: 250,
          //   ),
          // ),
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 250,
            // 寫法二：
            // color: Colors.deepOrange,
            color: const Color.fromARGB(126, 253, 244, 237),
          ),
          const SpaceBox(
            height: 40,
          ),
          const StyledText(text: 'Learn Flutter the fun way!'),
          const SpaceBox(
            height: 20,
          ),
          QuizTextButton(
              text: 'Start Quiz!',
              icon: Icons.arrow_forward_ios_rounded,
              onClick: handleStartQuiz)
        ],
      ),
    ));
  }
}
