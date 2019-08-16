import 'package:flutter/material.dart';
import 'package:myxpenses/providers/accounts.provider.dart';
import 'package:myxpenses/providers/date_interval.provider.dart';
import 'package:myxpenses/providers/expenses.provider.dart';
import 'package:myxpenses/screens/accounts/account_details.screen.dart';
import 'package:myxpenses/screens/accounts/accounts_list.screen.dart';
import 'package:myxpenses/screens/accounts/create_account.screen.dart';
import 'package:myxpenses/screens/accounts/edit_account.screen.dart';
import 'package:myxpenses/screens/expenses/create_expense.screen.dart';
import 'package:myxpenses/screens/expenses/edit_expense.screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => DateIntervalProvider()),
        ChangeNotifierProvider(builder: (_) => AccountsProvider()),
        ChangeNotifierProvider(builder: (_) => ExpensesProvider()),
      ],
      child: MaterialApp(
        title: 'myXpenses',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.teal[800],
        ),
        routes: {
          '/': (_) => AccountsListScreen(),
          'account-details': (_) => AccountDetailsScreen(),
          'create-account': (_) => CreateAccountScreen(),
          'edit-account': (_) => EditAccountScreen(),
          'create-expense': (_) => CreateExpenseScreen(),
          'edit-expense': (_) => EditExpenseScreen(),
        },
      ),
    );
  }
}
