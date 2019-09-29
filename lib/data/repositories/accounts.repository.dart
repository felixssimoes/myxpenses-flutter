import 'package:myxpenses/data/models/account.model.dart';
import 'package:rxdart/rxdart.dart';

class AccountsStore {
  final List<Account> _accounts = [];
  List<Account> get accounts => _accounts;

  Future<void> addAccount(Account account) async => _accounts.add(account);
}

class AccountsRepository {
  final _accounts = List<Account>();

  final _accountsList = BehaviorSubject<List<Account>>();

  dispose() {
    _accountsList.close();
  }

  Observable<List<Account>> get accounts => _accountsList.stream;

  Observable<Account> accountById(String id) =>
      _accountsList.stream.map((la) => la.firstWhere((a) => a.id == id));

  Future<List<Account>> loadAccounts() async {
    return [];
  }

  Future<Account> addAccount(String name) async {
    // final account = Account(id: DateTime.now().toString(), name: name);
    final account = Account(id: '123', name: name);
    _accounts.add(account);
    _accountsList.add(_accounts);
    return account;
  }

  Future<Account> updateAccount(Account account) async {
    _accounts[0] = account;
    _accountsList.add(_accounts);
    return account;
  }
}
