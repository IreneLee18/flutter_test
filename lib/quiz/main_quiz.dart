import 'package:flutter/material.dart';
import 'package:test/quiz/data/questions.dart';
import 'package:test/quiz/screen/question_screen.dart';
import 'package:test/quiz/screen/score_screen.dart';
import 'package:test/quiz/screen/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  // 因為初始狀態 activeScreen 和 handleChangeScreen 幾乎是同時建立好的
  // 所以在使用 handleStartQuiz: handleChangeScreen, 會報錯，因為他們幾乎同時建立好的，導致無法確保抓到正確的初始狀態
  // 為了解決這問題，我們需要在使用 activeScreen 和 handleChangeScreen 時確保它們已經建立好，以避免抓不到正確的初始狀態

  // Widget activeScreen = StartScreen(
  //   handleStartQuiz: handleChangeScreen,
  // );

  // void handleChangeScreen() {
  //   setState(() {
  //     activeScreen = const QuestionScreen();
  //   });
  // }

  // 解決方案：
  // initState：在這裡確保初始狀態先建立好
  // 初始化狀態只是在對象創建後立即調用，但技術上不是在對象創建期間調用
  // 這也就是為什麼技術上 activeScreen 會是 null，而我們需要在型別加上問號
  Widget? activeScreen;

  final List<String> selectedAnswer = [];

  @override
  void initState() {
    activeScreen = StartScreen(handleStartQuiz: handleChangeScreen);
    super.initState();
  }

  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);
    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = ScoreScreen(
          selectedAnswer: selectedAnswer,
          onRestart: handleRestart,
        );
      });
    }
  }

  void handleRestart() {
    setState(() {
      activeScreen = StartScreen(handleStartQuiz: handleChangeScreen);
      selectedAnswer.clear();
    });
  }

  void handleChangeScreen() {
    setState(() {
      activeScreen = QuestionScreen(onSelected: chooseAnswer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepOrangeAccent,
                Colors.orange,
                Color.fromRGBO(255, 224, 178, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: activeScreen,
        ),
      ),
    ));
  }
}
