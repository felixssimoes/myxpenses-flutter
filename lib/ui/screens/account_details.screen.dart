import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myxpenses/data/models/account.model.dart';
import 'package:myxpenses/data/models/expense.model.dart';
import 'package:myxpenses/data/providers/accounts.provider.dart';
import 'package:myxpenses/data/providers/expenses.provider.dart';
import 'package:myxpenses/ui/widgets/account_builder.dart';
import 'package:myxpenses/ui/widgets/date_interval_selector.dart';
import 'package:myxpenses/ui/widgets/expense_list_item.dart';
import 'package:provider/provider.dart';

class AccountDetailsScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final accountId = (ModalRoute.of(context).settings.arguments as Account).id;
    return AccountBuilder(
      accountId: accountId,
      builder: (BuildContext context, Account account, List expenses) {
        return Scaffold(
          appBar: AppBar(title: Text(account.name)),
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
              FlatButton(
                child: Text('Update'),
                onPressed: () {
                  final ua = Account(id: accountId, name: 'Name updated');
                  Provider.of<AccountsProvider>(context).updateAccount(ua);
                },
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
