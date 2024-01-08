import 'package:flutter/material.dart';
import 'package:test/quiz/data/questions.dart';
import 'package:test/quiz/quiz_summary/quiz_summary.dart';
import 'package:test/quiz/component/size_box.dart';
import 'package:test/quiz/component/text.dart';
import 'package:test/quiz/component/text_button.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({
    required this.onRestart,
    required this.selectedAnswer,
    super.key,
  });
  final void Function() onRestart;
  final List<String> selectedAnswer;

  @override
  State<StatefulWidget> createState() {
    return _ScoreScreenState();
  }
}

class _ScoreScreenState extends State<ScoreScreen> {
  List<Map<String, Object>> getSummary() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < widget.selectedAnswer.length; i++) {
      summary.add({
        'questionIndex': i,
        'questionTitle': questions[i].questionTitle,
        'questionAnswer': questions[i].questionAnswer[0],
        'userAnswer': widget.selectedAnswer[i],
        'isCorrect': questions[i].questionAnswer[0] == widget.selectedAnswer[i]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    int correctAnswer =
        getSummary().where((element) => (element['isCorrect'] as bool)).length;

    return (SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StyledText(
                text:
                    'You answered $correctAnswer out of ${questions.length} questions correctly!'),
            const SpaceBox(height: 30),
            QuizSummary(summary: getSummary()),
            const SpaceBox(height: 30),
            QuizTextButton(
                text: 'Restart Quiz!',
                icon: Icons.restart_alt,
                onClick: () {
                  widget.onRestart();
                })
          ],
        ),
      ),
    ));
  }
}
