import 'package:yamm_app/Transaction.dart';

class TransactionsList {
  TransactionsList._sharedInstance();
  static final TransactionsList _shared = TransactionsList._sharedInstance();
  factory TransactionsList() => _shared;

  final List<Transaction> _transactions = [];
  int get length => _transactions.length;

  void add({required Transaction transaction}) {
    _transactions.add(transaction);
  }

  void remove({required Transaction transaction}) {
    _transactions.remove(transaction);
  }

  Transaction? transaction({required int atIndex}) =>
      _transactions.length > atIndex ? _transactions[atIndex] : null;
}
