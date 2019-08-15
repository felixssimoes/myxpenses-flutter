import 'package:flutter/material.dart';
import 'package:myxpenses/models/account.model.dart';
import 'package:myxpenses/providers/accounts.provider.dart';
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
      body: AccountForm(
        account: account,
        onSaveAccount: ({String name}) {
          final accounts =
              Provider.of<AccountsProvider>(context, listen: false);
          final updatedAccount = account.copyWith(name: name);
          accounts.updateAccount(updatedAccount);
          Navigator.of(context).pop(updatedAccount);
        },
      ),
    );
  }
}
