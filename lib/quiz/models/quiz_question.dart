class QuizQuestion {
  const QuizQuestion({
    required this.questionTitle,
    required this.questionAnswer,
  });
  final String questionTitle;
  final List<String> questionAnswer;

  List<String> getShuffledAnswers() {
    // shuffle：打亂陣列
    // 不能直接這樣寫，因為 shuffle 不會 return 東西
    // A value of type 'void' can't be returned from the method 'getShuffledAnswers' because it has a return type of 'List<String>'
    // final newList = List.of(questionAnswer).shuffle();


    final newList = List.of(questionAnswer);
    newList.shuffle();
    return newList;
  }
}
