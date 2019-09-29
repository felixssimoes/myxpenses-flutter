import 'package:myxpenses/data/models/account.model.dart';
import 'package:rxdart/rxdart.dart';

class AccountsRepository {
  final _accounts = List<Account>();

  final _accountsList = BehaviorSubject<List<Account>>();

  dispose() {
    _accountsList.close();
  }

  Observable<List<Account>> get accounts => _accountsList.stream;

  // Observable<Account> accountById(String id) => _accountsList.value.firstWhere((a) => a.id == id);
  Observable<Account> accountById(String id) =>
      _accountsList.stream.transform(ScanStreamTransformer((a, la, i) {
        return la.firstWhere((a) => a.id == id);
      }, null));

  Future<List<Account>> loadAccounts() async {
    return [];
  }

  Future<Account> addAccount(String name) async {
    final account = Account(id: DateTime.now().toString(), name: name);
    _accounts.add(account);
    _accountsList.add(_accounts);
    return account;
  }
}
