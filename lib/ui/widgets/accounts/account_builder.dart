import 'package:flutter/material.dart';
import 'package:myxpenses/data/models/account.model.dart';
import 'package:myxpenses/data/models/expense.model.dart';
import 'package:myxpenses/data/providers/accounts.provider.dart';
import 'package:myxpenses/data/providers/date_interval.provider.dart';
import 'package:myxpenses/data/providers/expenses.provider.dart';
import 'package:provider/provider.dart';

class AccountBuilder extends StatelessWidget {
  final String accountId;
  final Widget Function(
    BuildContext context,
    Account account,
    List<Expense> expenses,
  ) builder;

  const AccountBuilder({
    Key key,
    @required this.accountId,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AccountsProvider>(context).findById(accountId);
    final dateInterval = Provider.of<DateIntervalProvider>(context);
    final expenses = Provider.of<ExpensesProvider>(context)
        .expensesForAccount(account)
        .where((e) =>
            !e.date.isBefore(dateInterval.startDate) &&
            e.date.isBefore(dateInterval.endDate))
        .toList();
    return builder(context, account, expenses);
  }
}
