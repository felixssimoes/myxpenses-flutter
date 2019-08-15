import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myxpenses/models/account.model.dart';
import 'package:myxpenses/models/expense.model.dart';
import 'package:myxpenses/widgets/accounts/account_builder.dart';

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
    return AccountBuilder(
      accountId: accountId,
      builder: (BuildContext context, Account account, List expenses) {
        return ListTile(
          title: Text(account.name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(NumberFormat.currency(name: 'EUR ')
                  .format(getTotalFromExpenses(expenses))),
              SizedBox(width: 5),
              Icon(Icons.chevron_right),
            ],
          ),
          onTap: onSelectAccount,
        );
      },
    );
  }
}
