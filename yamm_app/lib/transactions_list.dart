import 'package:flutter/material.dart';
import 'package:yamm_app/functions/save_and_load_csv.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/functions/filter_transactions.dart';

enum DateFrames { year, month, day }

class TransactionsListsNotifier with ChangeNotifier {
  late ValueNotifier<List<Transaction>> transactionsList =
      ValueNotifier<List<Transaction>>(List<Transaction>.empty(growable: true));
  late ValueNotifier<List<Transaction>> filteredTransactionsList =
      ValueNotifier<List<Transaction>>(List<Transaction>.empty(growable: true));
  late ValueNotifier<int> transactionsListId = ValueNotifier<int>(0);

  late ValueNotifier<DateFrames> dateFrame =
      ValueNotifier<DateFrames>(DateFrames.year);
  late ValueNotifier<int> year = ValueNotifier<int>(DateTime.now().year);
  late ValueNotifier<int> month = ValueNotifier<int>(DateTime.now().month);
  late ValueNotifier<int> day = ValueNotifier<int>(DateTime.now().day);

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

  void setyearFromPicker(BuildContext context) async {}

  void deleteListItem(int id) {}

  void editListItem(int id, Transaction transaction) {}

  void filterListDate() {
    if (dateFrame.value == DateFrames.year) {
      filteredTransactionsList.value =
          filterListYear(transactionsList.value, year.value);
    } else if (dateFrame.value == DateFrames.month) {
      filteredTransactionsList.value =
          filterListYear(transactionsList.value, year.value);
      filteredTransactionsList.value =
          filterListMonth(filteredTransactionsList.value, month.value);
    } else if (dateFrame.value == DateFrames.day) {
      filteredTransactionsList.value =
          filterListYear(transactionsList.value, year.value);
      filteredTransactionsList.value =
          filterListMonth(filteredTransactionsList.value, month.value);
      filteredTransactionsList.value =
          filterListDay(filteredTransactionsList.value, day.value);
    }
    notifyListeners();
  }
}
