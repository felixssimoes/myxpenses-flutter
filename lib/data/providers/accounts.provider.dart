import 'package:flutter/widgets.dart';
import 'package:myxpenses/data/models/account.model.dart';

class AccountsProvider with ChangeNotifier {
  List<Account> _accounts = [];

  List<Account> get accounts => [..._accounts];

  Future<Account> addAccount({@required String name}) async {
    final newAccount = Account(
      id: DateTime.now().toString(),
      name: name,
    );
    _accounts.add(newAccount);
    notifyListeners();
    return newAccount;
  }

  void updateAccount(Account account) {
    final index = _accounts.indexWhere(((a) => a.id == account.id));
    _accounts[index] = account;
    notifyListeners();
  }

  Future<void> deleteAccount(Account account) async {
    _accounts.removeWhere((a) => a.id == account.id);
    notifyListeners();
  }

  Account findById(String id) => _accounts.firstWhere((a) => a.id == id);
}
