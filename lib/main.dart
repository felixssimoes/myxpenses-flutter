import 'package:flutter/material.dart';
import 'package:myxpenses/data/providers/accounts.provider.dart';
import 'package:myxpenses/data/providers/date_interval.provider.dart';
import 'package:myxpenses/data/providers/expenses.provider.dart';
import 'package:myxpenses/ui/screens/account_details.screen.dart';
import 'package:myxpenses/ui/screens/accounts_list.screen.dart';
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
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (_) => AccountsListScreen(),
          '/account': (_) => AccountDetailsScreen(),
        },
      ),
    );
  }
}
