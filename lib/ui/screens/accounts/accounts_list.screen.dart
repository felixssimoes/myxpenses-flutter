import 'package:flutter/material.dart';
import 'package:myxpenses/app/app_navigator.dart';
import 'package:myxpenses/config/locator.dart';
import 'package:myxpenses/data/providers/accounts.provider.dart';
import 'package:myxpenses/ui/widgets/accounts/account_list_item.dart';
import 'package:myxpenses/ui/widgets/date_interval_selector.dart';
import 'package:provider/provider.dart';

class AccountsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accounts')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _onPressCreateAccount(context),
      ),
      body: Column(
        children: <Widget>[
          DateIntervalSelector(),
          Expanded(
            child: _buildAccountsList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountsList(BuildContext context) {
    return Consumer<AccountsProvider>(
      builder: (
        BuildContext context,
        AccountsProvider accountsProvider,
        Widget child,
      ) {
        return ListView.builder(
          itemCount: accountsProvider.accounts.length,
          itemBuilder: (BuildContext context, int index) {
            final account = accountsProvider.accounts[index];
            return AccountsListItem(
              accountId: account.id,
              onSelectAccount: () {
                locator<AppNavigator>().openAccountDetails(account: account);
              },
              onDeleteAccount: () {
                accountsProvider.deleteAccount(account);
              },
            );
          },
        );
      },
    );
  }

  void _onPressCreateAccount(BuildContext context) {
    locator<AppNavigator>().openCreateAccount();
  }
}
