import 'package:flutter/material.dart';
import 'package:myxpenses/models/account.model.dart';
import 'package:myxpenses/providers/accounts.provider.dart';
import 'package:provider/provider.dart';

class AccountFormData {
  String name;
}

class AccountForm extends StatefulWidget {
  final Account account;
  final Function(AccountFormData) onSaveAccount;

  AccountForm({
    this.account,
    this.onSaveAccount,
  });

  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _formData = AccountFormData();

  @override
  void initState() {
    super.initState();
    if (widget.account != null) {
      _formData.name = widget.account.name;
    } else {
      _formData.name = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildNameField(context),
          SizedBox(height: 30),
          _buildSaveButton(context),
        ],
      ),
    );
  }

  Widget _buildNameField(BuildContext context) {
    return TextFormField(
      autofocus: true,
      initialValue: _formData.name,
      decoration: InputDecoration(
        labelText: 'Account name',
        icon: Icon(Icons.account_box),
      ),
      onSaved: (value) => _formData.name = value,
      validator: (String value) {
        if (value.isEmpty) {
          return widget.account == null
              ? 'Please, enter the name for the new account'
              : 'Please enter the new name for this account';
        }

        // check if there's another account with the same name
        final accounts =
            Provider.of<AccountsProvider>(context, listen: false).accounts;
        final index = accounts.indexWhere((a) {
          if (a.name == value) {
            return widget.account == null || a.id != widget.account?.id;
          }
          return false;
        });
        if (index != -1) {
          return 'There\'s already an account with that name';
        }

        return null;
      },
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return RaisedButton(
      child: Text('Save'),
      color: Theme.of(context).accentColor,
      textColor: Colors.white,
      onPressed: () => _submitForm(),
    );
  }

  void _submitForm() {
    print(_formKey.currentState);
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    widget.onSaveAccount(_formData);
  }
}
