import 'package:flutter/material.dart';
import 'package:myxpenses/data/models/account.model.dart';
import 'package:myxpenses/data/models/expense.model.dart';
import 'package:myxpenses/ui/screens/accounts/account_details.screen.dart';
import 'package:myxpenses/ui/screens/accounts/accounts_list.screen.dart';
import 'package:myxpenses/ui/screens/accounts/create_account.screen.dart';
import 'package:myxpenses/ui/screens/accounts/edit_account.screen.dart';
import 'package:myxpenses/ui/screens/expenses/create_expense.screen.dart';
import 'package:myxpenses/ui/screens/expenses/edit_expense.screen.dart';

class AppRoutes {
  static const root = '/';
  static const accountDetails = '/account-details';
  static const createAccount = '/create-account';
  static const editAccount = '/edit-account';
  static const createExpense = '/create-expense';
  static const editExpense = '/edit-expense';
}

class AppNavigator {
  static Map<String, WidgetBuilder> setupRoutes(BuildContext context) {
    return {
      AppRoutes.root: (_) => AccountsListScreen(),
      AppRoutes.accountDetails: (_) => AccountDetailsScreen(),
      AppRoutes.createAccount: (_) => CreateAccountScreen(),
      AppRoutes.editAccount: (_) => EditAccountScreen(),
      AppRoutes.createExpense: (_) => CreateExpenseScreen(),
      AppRoutes.editExpense: (_) => EditExpenseScreen(),
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
      AppRoutes.createAccount,
    );
  }

  void openAccountDetails({@required Account account}) {
    rootNavigatorKey.currentState.pushNamed(
      AppRoutes.accountDetails,
      arguments: account,
    );
  }

  void openEditAccount({@required Account account}) {
    rootNavigatorKey.currentState.pushNamed(
      AppRoutes.editAccount,
      arguments: account,
    );
  }

  void openCreateExpense({@required Account account}) {
    rootNavigatorKey.currentState.pushNamed(
      AppRoutes.createExpense,
      arguments: account,
    );
  }

  void openEditExpense({@required Expense expense}) {
    rootNavigatorKey.currentState.pushNamed(
      AppRoutes.editExpense,
      arguments: expense,
    );
  }
}
