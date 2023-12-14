import 'package:flutter/material.dart';
import 'package:yamm_app/functions/save_and_load_csv.dart';
import 'package:yamm_app/transaction.dart';

class TransactionsListsNotifier with ChangeNotifier {
  late ValueNotifier<List<Transaction>> transactionsList =
      ValueNotifier<List<Transaction>>(List<Transaction>.empty(growable: true));
  late ValueNotifier<List<Transaction>> filteredTransactionsList =
      ValueNotifier<List<Transaction>>(List<Transaction>.empty(growable: true));
  late ValueNotifier<int> transactionsListId = ValueNotifier<int>(0);

  void setList(List<Transaction> lst) {
    transactionsList.value = lst;
    filteredTransactionsList.value = lst;
    transactionsListId.value = getLastID(transactionsList.value);
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    transactionsList.value.add(transaction);
    filteredTransactionsList.value = transactionsList.value;
    transactionsListId.value = getLastID(transactionsList.value);
    notifyListeners();
  }

  void deleteListItem(int id) {}

  void editListItem(int id, Transaction transaction) {}

  void filterList() {}
}
