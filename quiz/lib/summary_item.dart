import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quiz/question_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.item, {super.key});

  final Map<String, Object> item;

  @override
  Widget build(BuildContext context) {
    final isCorrect = item['correct_answer'] == item['chosen_answer'];

    return Row(
      children: [
        QuestionIdentifier(
          id: item['question_index'],
          correct: isCorrect,
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['question'] as String,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text('Correct Answer: ${item['correct_answer']}',
                style: TextStyle(
                  color: Color.fromARGB(255, 68, 232, 144),
                ),
              ),
              if (!isCorrect)
                Text('Chosen Answer: ${item['chosen_answer']}',
                  style: TextStyle(
                    color: Color.fromARGB(255, 225, 128, 103),
                  ),
                ),
              SizedBox(height: 15,),
            ],
          ),
        ),
      ],
    );
  }
}
