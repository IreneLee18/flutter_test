import 'package:flutter/material.dart';
import 'package:test/quiz/data/questions.dart';
import 'package:test/quiz/component/quiz_button.dart';
import 'package:test/quiz/component/size_box.dart';
import 'package:test/quiz/component/text.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({required this.onSelected, super.key});
  final void Function(String props) onSelected;

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentIndex = 0;

  onAnswer(String answer) {
    setState(() {
      // widget：
      // 1. 在 _QuestionScreenState 中可以使用 widget 來存取 QuestionScreen 的屬性和方法。
      // 2. 使用 widget.onSelected(answer) 來呼叫 QuestionScreen 中的 onSelected 方法，
      //    從而在父 widget 中執行相應的操作。
      widget.onSelected(answer);
      currentIndex += 1;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentIndex];

    return (SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              // width: 300,
              child: StyledText(text: currentQuestion.questionTitle),
            ),
            const SpaceBox(height: 30),
            // 若要使用 map 需在前面使用 ...，來將陣列展開
            ...currentQuestion.getShuffledAnswers().map(
                  (answerText) => QuizButton(
                    text: answerText,
                    onClick: () {
                      onAnswer(answerText);
                    },
                  ),
                ),
          ],
        ),
      ),
    ));
  }
}
