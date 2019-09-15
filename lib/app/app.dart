import 'package:flutter/material.dart';
import 'package:myxpenses/app/app_navigator.dart';
import 'package:myxpenses/config/locator.dart';
import 'package:myxpenses/data/providers/accounts.provider.dart';
import 'package:myxpenses/data/providers/date_interval.provider.dart';
import 'package:myxpenses/data/providers/expenses.provider.dart';
import 'package:provider/provider.dart';

class MyXpensesApp extends StatelessWidget {
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
        routes: AppNavigator.setupRoutes(context),
        navigatorKey: locator<AppNavigator>().rootNavigatorKey,
      ),
    );
  }
}
