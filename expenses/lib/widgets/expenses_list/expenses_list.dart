import 'package:flutter/material.dart';

import 'package:expenses/widgets/expenses_list/expense_item.dart';
import 'package:expenses/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onExpenseDeleted,
  });

  final List<Expense> expenses;
  final Function(Expense) onExpenseDeleted;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        child: ExpenseItem(expenses[index]),
        onDismissed: (direction) {
          onExpenseDeleted(expenses[index]);
        },
      ),
    );
  }
}