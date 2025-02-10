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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<int, List<String>>> attempts = [];
  var attempt = 0;

  @override
  void initState() {
    super.initState();
    _currentScreen = StartScreen(switchScreen);
  }

  void chooseAnswer(String answer) {
    chosenAnswers.add(answer);

    if (chosenAnswers.length == questions.length) {
      setState(() {
        attempt++;
        attempts.add({
          attempt: List.of(chosenAnswers),
        });

        _currentScreen = ResultsScreen(
          List.of(chosenAnswers),
          onRestart: restartQuiz,
        );
        chosenAnswers.clear();
      });
    }
  }

  void switchScreen() {
    setState(() {
      _currentScreen = QuestionsScreen(onSelectAnswer: chooseAnswer);
    });
  }

  void restartQuiz() {
    setState(() {
      chosenAnswers.clear();
      _currentScreen = StartScreen(switchScreen);
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Flutteryy Quiz'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: _openDrawer,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  chosenAnswers.clear();
                  _currentScreen = StartScreen(switchScreen);
                });
              },
            ),
          ],
        ),
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
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Attempts',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
            ...attempts.map((attempt) {
              return ListTile(
                title: Text('Attempt ${attempt.keys.first}'),
                onTap: () {
                  setState(() {
                    chosenAnswers.clear();
                    _currentScreen = ResultsScreen(
                      attempt.values.first,
                      onRestart: restartQuiz,
                    );
                  });
                },
              );
            }),
          ]),
        ),
      ),
    );
  }
}
