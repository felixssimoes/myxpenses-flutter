import 'package:flutter/foundation.dart';

class Expense {
  final String id;
  final String accountId;
  final double value;
  final DateTime date;

  Expense({
    @required this.id,
    @required this.accountId,
    @required this.value,
    @required this.date,
  });
}

double getTotalFromExpenses(List<Expense> expenses) {
  return expenses.length == 0
      ? 0
      : expenses.map((e) => e.value).reduce((a, c) => a + c);
}
