import 'package:flutter/material.dart';
import 'package:myxpenses/providers/accounts.provider.dart';
import 'package:myxpenses/widgets/accounts/account_form.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an Account'),
      ),
      body: AccountForm(
        onSaveAccount: ({String name}) => _onSaveAccount(context, name),
      ),
    );
  }

  _onSaveAccount(BuildContext context, String name) {
    final accounts = Provider.of<AccountsProvider>(context);
    accounts.addAccount(name: name);
    Navigator.of(context).pop(true);
  }
}
