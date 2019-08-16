import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:myxpenses/models/account.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _accountsPreferenceKey = 'com.myxpenses.accounts';

class AccountsProvider with ChangeNotifier {
  List<Account> _accounts = [];

  List<Account> get accounts => [..._accounts];

  AccountsProvider() {
    loadAccounts();
  }

  Account findById(String id) {
    return _accounts.firstWhere((a) => a.id == id, orElse: () => null);
  }

  Future<Account> addAccount({@required String name}) async {
    final newAccount = Account(
      id: DateTime.now().toString(),
      name: name,
    );
    _accounts.add(newAccount);
    await _saveAccounts();
    notifyListeners();
    return newAccount;
  }

  Future<void> updateAccount(Account account) async {
    final index = _accounts.indexWhere(((a) => a.id == account.id));
    _accounts[index] = account;
    await _saveAccounts();
    notifyListeners();
  }

  Future<void> deleteAccount(Account account) async {
    _accounts.removeWhere((a) => a.id == account.id);
    await _saveAccounts();
    notifyListeners();
  }

  Future<void> loadAccounts() async {
    final preferences = await SharedPreferences.getInstance();
    final jsonString = preferences.getString(_accountsPreferenceKey);
    if (jsonString == null) return;

    final jsonValue = json.decode(jsonString) as List<dynamic>;
    _accounts = jsonValue.map((a) => Account.fromJson(a)).toList();
    notifyListeners();
  }

  Future<void> _saveAccounts() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(_accountsPreferenceKey, json.encode(_accounts));
  }
}
