import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:myxpenses/models/account.model.dart';
import 'package:myxpenses/models/expense.model.dart';

class ExpensesProvider with ChangeNotifier {
  List<Expense> _expenses = [];

  Expense findById(String id) {
    return _expenses.firstWhere((e) => e.id == id);
  }

  List<Expense> expensesForAccount(Account account) {
    return _expenses.where((e) => e.accountId == account.id).toList();
  }

  Future<void> addExpense({@required Account account}) async {
    final expense = Expense(
      id: DateTime.now().toString(),
      accountId: account.id,
      value: Random().nextDouble() * 100,
      date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
    );
    _expenses.add(expense);
    _sortExpenses();
    notifyListeners();
  }

  void _sortExpenses() {
    _expenses.sort((e1, e2) => e2.date.compareTo(e1.date));
  }
}
