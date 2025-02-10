import 'package:flutter/material.dart';

import 'package:quiz/start_screen.dart';
import 'package:quiz/questions.dart';
import 'package:quiz/data/questions.dart';
import 'package:quiz/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Widget? _currentScreen;
  final List<String> chosenAnswers = [];

  @override
  void initState() {
    super.initState();
    _currentScreen = StartScreen(switchScreen);
  }

  void chooseAnswer(String answer) {
    chosenAnswers.add(answer);

    if(chosenAnswers.length == questions.length) {
      setState(() {
        _currentScreen = ResultsScreen(List.of(chosenAnswers));
        debugPrint('chosenAnswers: $chosenAnswers');
        chosenAnswers.clear();
      });
    }
  }

  void switchScreen() {
    setState(() {
      _currentScreen = QuestionsScreen(onSelectAnswer: chooseAnswer);
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 96, 65, 198),
                Color.fromARGB(255, 127, 19, 194),
              ],
            ),
          ),
          child: _currentScreen,
        ),
      ),
    );
  }
}
