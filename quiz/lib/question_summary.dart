import 'package:flutter/material.dart';

import 'package:quiz/summary_item.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary(this.summary, {super.key});

  final List<Map<String, Object>> summary;

  @override
  Widget build(BuildContext context) {
    return Column(
          children: summary.map((question) => SummaryItem(question)).toList(),
        );
  }
}
