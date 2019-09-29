import 'package:flutter/material.dart';
import 'package:myxpenses/data/models/account.model.dart';
import 'package:myxpenses/data/models/expense.model.dart';
import 'package:myxpenses/ui/screens/accounts/account_details.screen.dart';
import 'package:myxpenses/ui/screens/accounts/create_account.screen.dart';
import 'package:myxpenses/ui/screens/accounts/edit_account.screen.dart';
import 'package:myxpenses/ui/screens/accounts/list/accounts_list.screen.dart';
import 'package:myxpenses/ui/screens/expenses/create_expense.screen.dart';
import 'package:myxpenses/ui/screens/expenses/edit_expense.screen.dart';

class AppNavigator {
  static Map<String, WidgetBuilder> setupRoutes(BuildContext context) {
    return {
      '/': (_) => AccountsListScreen(),
      '/account-details': (_) => AccountDetailsScreen(),
      '/create-account': (_) => CreateAccountScreen(),
      '/edit-account': (_) => EditAccountScreen(),
      '/create-expense': (_) => CreateExpenseScreen(),
      '/edit-expense': (_) => EditExpenseScreen(),
    };
  }

  final rootNavigatorKey = GlobalKey<NavigatorState>();

  bool pop([value]) {
    return rootNavigatorKey.currentState.pop(value);
  }

  void popToAccountsList() {
    rootNavigatorKey.currentState.popUntil(ModalRoute.withName('/'));
  }

  void openCreateAccount() {
    rootNavigatorKey.currentState.pushNamed(
      '/create-account',
    );
  }

  void openAccountDetails({@required Account account}) {
    rootNavigatorKey.currentState.pushNamed(
      '/account-details',
      arguments: account,
    );
  }

  void openEditAccount({@required Account account}) {
    rootNavigatorKey.currentState.pushNamed(
      '/edit-account',
      arguments: account,
    );
  }

  void openCreateExpense({@required Account account}) {
    rootNavigatorKey.currentState.pushNamed(
      '/create-expense',
      arguments: account,
    );
  }

  void openEditExpense({@required Expense expense}) {
    rootNavigatorKey.currentState.pushNamed(
      '/edit-expense',
      arguments: expense,
    );
  }
}
