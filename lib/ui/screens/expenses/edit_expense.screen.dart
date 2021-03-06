import 'package:flutter/material.dart';
import 'package:myxpenses/app/app_navigator.dart';
import 'package:myxpenses/config/locator.dart';
import 'package:myxpenses/data/models/expense.model.dart';
import 'package:myxpenses/data/providers/expenses.provider.dart';
import 'package:myxpenses/ui/widgets/expenses/expense_form.dart';
import 'package:provider/provider.dart';

class EditExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expense = ModalRoute.of(context).settings.arguments as Expense;
    return Scaffold(
      appBar: AppBar(title: Text('Edit Expense')),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            ExpenseForm(
              expense: expense,
              onSaveExpense: (formData) =>
                  _saveExpense(context, formData, expense),
            ),
            RaisedButton(
              child: Text('Delete Expense'),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () => _deleteExpense(context, expense),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveExpense(
    BuildContext context,
    ExpenseFormData formData,
    Expense expense,
  ) async {
    await Provider.of<ExpensesProvider>(context, listen: false)
        .updateExpense(expense.copyWith(
      category: formData.category,
      date: formData.date,
      value: formData.value,
    ));
    locator<AppNavigator>().pop();
  }

  Future<void> _deleteExpense(BuildContext context, Expense expense) async {
    await Provider.of<ExpensesProvider>(context, listen: false)
        .deleteExpense(expense);
    locator<AppNavigator>().pop();
  }
}
