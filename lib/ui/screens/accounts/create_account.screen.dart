import 'package:flutter/material.dart';
import 'package:myxpenses/app/app_navigator.dart';
import 'package:myxpenses/config/locator.dart';
import 'package:myxpenses/data/providers/accounts.provider.dart';
import 'package:myxpenses/ui/widgets/accounts/account_form.dart';
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
    final accounts = Provider.of<AccountsProvider>(context, listen: false);
    accounts.addAccount(name: data.name);
    locator<AppNavigator>().pop();
  }
}
