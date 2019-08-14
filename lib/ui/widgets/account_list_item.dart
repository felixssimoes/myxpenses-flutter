import 'package:flutter/material.dart';
import 'package:myxpenses/data/providers/accounts.provider.dart';
import 'package:provider/provider.dart';

class AccountsListItem extends StatelessWidget {
  final Function onSelectAccount;
  final Function onDeleteAccount;
  final String accountId;

  const AccountsListItem({
    Key key,
    @required this.onSelectAccount,
    @required this.onDeleteAccount,
    @required this.accountId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AccountsProvider>(context, listen: false)
        .findById(accountId);
    return ListTile(
      title: Text(account.name),
      onTap: onSelectAccount,
    );
  }
}
