import 'package:flutter/material.dart';
import 'package:myxpenses/models/account.model.dart';
import 'package:myxpenses/providers/accounts.provider.dart';
import 'package:myxpenses/widgets/accounts/account_form.dart';
import 'package:provider/provider.dart';

class EditAccountScreen extends StatelessWidget {
  final Account account;
  EditAccountScreen(this.account);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${account.name} Settings'),
      ),
      body: AccountForm(
        account: account,
        onSaveAccount: ({String name}) => _onSaveAccount(context, name),
      ),
    );
  }

  _onSaveAccount(BuildContext context, String name) {
    final accounts = Provider.of<AccountsProvider>(context);
    final updatedAccount = account.copyWith(name: name);
    accounts.updateAccount(updatedAccount);
    Navigator.of(context).pop(updatedAccount);
  }
}
