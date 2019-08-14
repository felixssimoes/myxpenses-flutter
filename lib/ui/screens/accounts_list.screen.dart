import 'package:flutter/material.dart';
import 'package:myxpenses/data/providers/accounts.provider.dart';
import 'package:myxpenses/ui/widgets/account_list_item.dart';
import 'package:myxpenses/ui/widgets/date_interval_selector.dart';
import 'package:provider/provider.dart';

class AccountsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accounts')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Provider.of<AccountsProvider>(context, listen: false)
              .addAccount(name: 'Account');
        },
      ),
      body: Consumer<AccountsProvider>(
        builder: (
          BuildContext context,
          AccountsProvider value,
          Widget child,
        ) {
          return Column(
            children: <Widget>[
              DateIntervalSelector(),
              Expanded(
                child: ListView.builder(
                  itemCount: value.accounts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final account = value.accounts[index];
                    return AccountsListItem(
                      accountId: account.id,
                      onSelectAccount: () {},
                      onDeleteAccount: () {
                        value.deleteAccount(account);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
