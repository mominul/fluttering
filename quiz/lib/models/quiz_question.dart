class QuizQuestion {
  final String question;
  final List<String> answers;

  const QuizQuestion(this.question, this.answers);

  List<String> shuffledAnswers() {
    final shuffledAnswers = List<String>.from(answers);
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }
}