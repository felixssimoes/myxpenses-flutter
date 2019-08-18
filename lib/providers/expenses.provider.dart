import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:myxpenses/models/account.model.dart';
import 'package:myxpenses/models/expense.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const _expensesPreferenceKey = 'com.myxpenses.expenses';

class ExpensesProvider extends ChangeNotifier {
  List<Expense> _expenses = [];

  ExpensesProvider() {
    loadExpenses();
  }

  Expense findById(String id) {
    return _expenses.firstWhere((e) => e.id == id, orElse: () => null);
  }

  List<Expense> expensesForAccount(Account account) {
    return _expenses.where((e) => e.accountId == account.id).toList();
  }

  Future<void> addRandomExpense({
    @required Account account,
  }) =>
      addExpense(
        account: account,
        value: Random().nextDouble() * 100,
        date: DateTime.now().subtract(Duration(days: Random().nextInt(30))),
        category: 'expense category',
      );

  Future<void> addExpense({
    @required Account account,
    @required String category,
    @required DateTime date,
    @required double value,
  }) async {
    final expense = Expense(
      id: Uuid().v1(),
      accountId: account.id,
      value: value,
      date: date,
      category: category,
    );
    _expenses.add(expense);
    _sortExpenses();
    await _saveExpenses();
    notifyListeners();
  }

  Future<void> updateExpense(Expense expense) async {
    final index = _expenses.indexWhere(((e) => e.id == expense.id));
    _expenses[index] = expense;
    _sortExpenses();
    await _saveExpenses();
    notifyListeners();
  }

  Future<void> deleteExpense(Expense expense) async {
    _expenses.removeWhere((e) => e.id == expense.id);
    await _saveExpenses();
    notifyListeners();
  }

  Future<void> deleteAllExpensesForAccount(Account account) async {
    _expenses.removeWhere((e) => e.accountId == account.id);
    await _saveExpenses();
    notifyListeners();
  }

  void _sortExpenses() {
    _expenses.sort((e1, e2) => e2.date.compareTo(e1.date));
  }

  Future<void> loadExpenses() async {
    final preferences = await SharedPreferences.getInstance();
    final jsonString = preferences.getString(_expensesPreferenceKey);
    if (jsonString == null) return;

    final jsonValue = json.decode(jsonString) as List<dynamic>;
    _expenses = jsonValue.map((e) => Expense.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> _saveExpenses() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(_expensesPreferenceKey, json.encode(_expenses));
  }
}
