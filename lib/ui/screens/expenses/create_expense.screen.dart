import 'package:flutter/material.dart';
import 'package:myxpenses/data/models/account.model.dart';
import 'package:myxpenses/data/providers/expenses.provider.dart';
import 'package:myxpenses/ui/widgets/expenses/expense_form.dart';
import 'package:provider/provider.dart';

class CreateExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final account = ModalRoute.of(context).settings.arguments as Account;
    return Scaffold(
      appBar: AppBar(title: Text('Edit Expense')),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: ExpenseForm(
          onSaveExpense: (formData) => _saveExpense(context, formData, account),
        ),
      ),
    );
  }

  Future<void> _saveExpense(
    BuildContext context,
    ExpenseFormData formData,
    Account account,
  ) async {
    await Provider.of<ExpensesProvider>(context, listen: false).addExpense(
      account: account,
      category: formData.category,
      date: formData.date,
      value: formData.value,
    );
    Navigator.of(context).pop();
  }
}
