import 'package:flutter/material.dart';
import 'package:myxpenses/models/account.model.dart';
import 'package:myxpenses/providers/accounts.provider.dart';
import 'package:myxpenses/providers/expenses.provider.dart';
import 'package:myxpenses/widgets/accounts/account_form.dart';
import 'package:provider/provider.dart';

class EditAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final account = (ModalRoute.of(context).settings.arguments as Account);
    return Scaffold(
      appBar: AppBar(
        title: Text('${account.name} Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildForm(context, account),
          _buildDeleteButton(context, account),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, Account account) {
    return AccountForm(
      account: account,
      onSaveAccount: ({String name}) {
        final accounts = Provider.of<AccountsProvider>(context, listen: false);
        final updatedAccount = account.copyWith(name: name);
        accounts.updateAccount(updatedAccount);
        Navigator.of(context).pop(updatedAccount);
      },
    );
  }

  Widget _buildDeleteButton(BuildContext context, Account account) {
    return RaisedButton(
      child: Text('Delete account'),
      color: Colors.red,
      textColor: Colors.white,
      onPressed: () => _onPressDeleteAccount(context, account),
    );
  }

  void _onPressDeleteAccount(BuildContext context, Account account) async {
    final bool shouldDelete = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text(
              'Do you want to delete this account and all associted expenses?\n\nThis operation cannot be undone.'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
              child: Text('yes'),
              onPressed: () {
                return Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
    if (shouldDelete == true) {
      Provider.of<ExpensesProvider>(context, listen: false)
          .deleteAllExpensesForAccount(account);
      Provider.of<AccountsProvider>(context, listen: false)
          .deleteAccount(account);
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    }
  }
}
