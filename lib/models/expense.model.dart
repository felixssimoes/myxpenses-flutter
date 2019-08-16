import 'package:flutter/foundation.dart';

class Expense {
  final String id;
  final String accountId;
  final double value;
  final DateTime date;
  final String category;

  Expense({
    @required this.id,
    @required this.accountId,
    @required this.value,
    @required this.date,
    @required this.category,
  });

  Expense.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        accountId = json['account_id'],
        value = json['value'],
        date = DateTime.parse(json['date']),
        category = json['category'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'account_id': accountId,
        'value': value,
        'date': date.toIso8601String(),
        'category': category,
      };

  Expense copyWith({
    double value,
    DateTime date,
    String category,
  }) =>
      Expense(
        id: this.id,
        accountId: this.accountId,
        value: value ?? this.value,
        date: date ?? this.date,
        category: category ?? this.category,
      );
}

double getTotalFromExpenses(List<Expense> expenses) {
  return expenses.length == 0
      ? 0
      : expenses.map((e) => e.value).reduce((a, c) => a + c);
}
