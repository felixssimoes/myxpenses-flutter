import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myxpenses/models/account.model.dart';
import 'package:myxpenses/models/expense.model.dart';
import 'package:myxpenses/providers/accounts.provider.dart';
import 'package:myxpenses/providers/expenses.provider.dart';
import 'package:myxpenses/widgets/accounts/account_builder.dart';
import 'package:myxpenses/widgets/date_interval_selector.dart';
import 'package:myxpenses/widgets/expenses/expense_list_item.dart';
import 'package:provider/provider.dart';

class AccountDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountId = (ModalRoute.of(context).settings.arguments as Account).id;
    return AccountBuilder(
      accountId: accountId,
      builder: (BuildContext context, Account account, List expenses) {
        if (account == null) {
          Navigator.of(context).pop();
          return Scaffold();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(account.name),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => Navigator.of(context).pushNamed(
                  'edit-account',
                  arguments: account,
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_alarm),
            onPressed: () {
              Provider.of<ExpensesProvider>(context, listen: false)
                  .addExpense(account: account);
            },
          ),
          body: Column(
            children: <Widget>[
              DateIntervalSelector(),
              Row(
                children: <Widget>[
                  Text('Total expenses'),
                  SizedBox(width: 20),
                  Text(NumberFormat.currency(name: 'EUR')
                      .format(getTotalFromExpenses(expenses))),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (BuildContext context, int index) {
                    final expense = expenses[index];
                    return ExpenseListItem(expenseId: expense.id);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
