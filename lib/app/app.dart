import 'package:flutter/material.dart';
import 'package:myxpenses/app/app_navigator.dart';
import 'package:myxpenses/config/locator.dart';
import 'package:myxpenses/data/models/account.model.dart';
import 'package:myxpenses/data/providers/accounts.provider.dart';
import 'package:myxpenses/data/providers/date_interval.provider.dart';
import 'package:myxpenses/data/providers/expenses.provider.dart';
import 'package:myxpenses/data/repositories/accounts.repository.dart';
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
        // routes: AppNavigator.setupRoutes(context),
        // navigatorKey: locator<AppNavigator>().rootNavigatorKey,
        home: Screen(),
      ),
    );
  }
}

final repo = AccountsRepository();
int count = 0;

class Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamProvider<Account>.value(
            value: repo.accountById('123'),
            child: Consumer<Account>(
              builder: (c, a, _) {
                print('show account stream provider/consumer');
                return Center(child: Text(a?.name ?? 'no account'));
              },
            ),
          ),
          StreamBuilder<Account>(
            stream: repo.accountById('123'),
            builder: (_, AsyncSnapshot<Account> s) {
              print('show account stream builder');
              if (!s.hasData) {
                return Text('no account yet');
              }
              return Text(s.data.name);
            },
          ),
          RaisedButton(
            child: Text('add account'),
            onPressed: () {
              count++;
              repo.addAccount('name $count');
            },
          ),
          StreamBuilder<Account>(
            stream: repo.accountById('123'),
            builder: (_, AsyncSnapshot<Account> s) {
              print('edit account button');
              if (!s.hasData) {
                return Text('no account yet');
              }
              return RaisedButton(
                child: Text('edit account'),
                onPressed: () {
                  count++;
                  final a = s.data.copyWith(name: 'name $count');
                  repo.updateAccount(a);
                },
              );
            },
          ),
          StreamBuilder<List<Account>>(
            stream: repo.accounts,
            builder: (_, AsyncSnapshot<List<Account>> s) {
              print('accounts list');
              if (!s.hasData) {
                return Text('no accounts yet');
              }
              return Column(
                children: s.data.map((a) => Text(a.name)).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
