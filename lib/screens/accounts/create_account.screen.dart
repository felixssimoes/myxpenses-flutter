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
      body: Container(
        padding: const EdgeInsets.all(15),
        child: AccountForm(
          onSaveAccount: (AccountFormData data) =>
              _onSaveAccount(context, data),
        ),
      ),
    );
  }

  _onSaveAccount(BuildContext context, AccountFormData data) {
    final accounts = Provider.of<AccountsProvider>(context);
    accounts.addAccount(name: data.name);
    Navigator.of(context).pop(true);
  }
}
