import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myxpenses/data/models/account.model.dart';
import 'package:myxpenses/data/models/expense.model.dart';
import 'package:myxpenses/ui/widgets/accounts/account_builder.dart';
import 'package:myxpenses/ui/widgets/date_interval_selector.dart';
import 'package:myxpenses/ui/widgets/expenses/expense_list_item.dart';

class AccountDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountId = (ModalRoute.of(context).settings.arguments as Account).id;
    return AccountBuilder(
      accountId: accountId,
      builder: (BuildContext context, Account account, List expenses) {
        if (account == null) {
          return Scaffold();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(account.name),
            actions: <Widget>[
              _buildAccountSettingsButton(context, account),
            ],
          ),
          floatingActionButton: _buildAddExpenseButton(context, account),
          body: Column(
            children: <Widget>[
              DateIntervalSelector(),
              _buildTotalBar(expenses),
              Expanded(
                child: _buildExpensesList(expenses),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildExpensesList(List<Expense> expenses) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (BuildContext context, int index) {
        final expense = expenses[index];
        return ExpenseListItem(
          expenseId: expense.id,
          onSelectExpense: () {
            Navigator.of(context)
                .pushNamed('/edit-expense', arguments: expense);
          },
        );
      },
    );
  }

  Widget _buildTotalBar(List<Expense> expenses) {
    return Row(
      children: <Widget>[
        Text('Total expenses'),
        SizedBox(width: 20),
        Text(NumberFormat.currency(name: 'EUR')
            .format(getTotalFromExpenses(expenses))),
      ],
    );
  }

  Widget _buildAccountSettingsButton(BuildContext context, Account account) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () => Navigator.of(context).pushNamed(
        '/edit-account',
        arguments: account,
      ),
    );
  }

  Widget _buildAddExpenseButton(BuildContext context, Account account) {
    return FloatingActionButton(
      child: Icon(Icons.add_alarm),
      onPressed: () {
        Navigator.of(context).pushNamed('/create-expense', arguments: account);
      },
    );
  }
}
