import 'package:flutter/material.dart';
import 'package:test/quiz/component/size_box.dart';
import 'package:test/quiz/quiz_summary/quiz_answer.dart';
import 'package:test/quiz/quiz_summary/quiz_index.dart';
import 'package:test/quiz/quiz_summary/quiz_title.dart';

class QuizSummary extends StatelessWidget {
  const QuizSummary({required this.summary, super.key});
  final List<Map<String, Object>> summary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: SingleChildScrollView(
        child: (Column(
          children: summary.map((summary) {
            return (Row(
              // 使文字整體貼齊上方
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuizIndex(
                  num: (summary['questionIndex'] as int) + 1,
                  isCorrect: (summary['isCorrect'] as bool),
                ),
                // 加上 Expanded 可以防止破版，他的目的是在於限制寬度，寬度僅限於 Row 的最大寬度
                // 沒有加上就會超出 Row 的最大寬度
                Expanded(
                  child: Column(
                    // 使文字整體貼齊左方
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QuizTitle(title: (summary['questionTitle'] as String)),
                      const SpaceBox(height: 5),
                      QuizText(
                        text: (summary['userAnswer'] as String),
                        color: const Color.fromARGB(255, 0, 95, 129),
                      ),
                      const SpaceBox(height: 5),
                      QuizText(
                        text: (summary['questionAnswer'] as String),
                        color: const Color.fromARGB(255, 139, 30, 0),
                      ),
                      const SpaceBox(height: 10),
                    ],
                  ),
                )
              ],
            ));
          }).toList(),
        )),
      ),
    );
  }
}
