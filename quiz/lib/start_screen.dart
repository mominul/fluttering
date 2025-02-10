import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.switchScreen, {super.key});

  final void Function() switchScreen;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset('assets/images/quiz-logo.png', width: 300),
        SizedBox(height: 70),
        Text(
          'Learn Flutter the fun way!',
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 40),
        OutlinedButton.icon(
          onPressed: switchScreen,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          label: Text('Start Quiz'),
          icon: Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
        ),
      ]),
    );
  }
}
