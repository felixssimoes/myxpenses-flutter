import 'package:flutter/material.dart';
import 'package:myxpenses/data/models/account.model.dart';
import 'package:myxpenses/data/models/expense.model.dart';
import 'package:myxpenses/ui/screens/accounts/account_details.screen.dart';
import 'package:myxpenses/ui/screens/accounts/accounts_list.screen.dart';
import 'package:myxpenses/ui/screens/accounts/create_account.screen.dart';
import 'package:myxpenses/ui/screens/accounts/edit_account.screen.dart';
import 'package:myxpenses/ui/screens/expenses/create_expense.screen.dart';
import 'package:myxpenses/ui/screens/expenses/edit_expense.screen.dart';

class AppNavigator {
  static Map<String, WidgetBuilder> setupRoutes(BuildContext context) {
    return {
      '/': (_) => AccountsListScreen(),
      'account-details': (_) => AccountDetailsScreen(),
      'create-account': (_) => CreateAccountScreen(),
      'edit-account': (_) => EditAccountScreen(),
      'create-expense': (_) => CreateExpenseScreen(),
      'edit-expense': (_) => EditExpenseScreen(),
    };
  }

  final rootNavigatorKey = GlobalKey<NavigatorState>();

  void openCreateAccount() {}

  void openAccountDetails({@required Account account}) {}

  void openEditAccount({@required Account account}) {}

  void openCreateExpense({@required Account account}) {}

  void openEditExpense({@required Expense expense}) {}
}
