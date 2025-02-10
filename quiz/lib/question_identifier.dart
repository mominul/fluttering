import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  const QuestionIdentifier({super.key, required this.id, required this.correct});

  final id;
  final bool correct;

  @override
  Widget build(BuildContext context) {
    final question_number = (id as int) + 1;

    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: correct ? Colors.green : Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          question_number.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
