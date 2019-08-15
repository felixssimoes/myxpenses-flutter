import 'package:flutter/material.dart';
import 'package:myxpenses/models/account.model.dart';
import 'package:myxpenses/providers/accounts.provider.dart';
import 'package:provider/provider.dart';

class AccountForm extends StatefulWidget {
  final Account account;
  final Function({String name}) onSaveAccount;

  AccountForm({
    this.account,
    this.onSaveAccount,
  });

  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  TextEditingController _nameController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.account?.name);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNameField(context),
              SizedBox(height: 30),
              _buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(labelText: 'Account name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please, give the account a name.';
        }

        // check if there's another account with the same name
        final accounts = Provider.of<AccountsProvider>(context).accounts;
        final index = accounts.indexWhere((a) {
          if (a.name == value) {
            return widget.account == null || a.id == widget.account.id;
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
    widget.onSaveAccount(name: _nameController.text);
  }
}
