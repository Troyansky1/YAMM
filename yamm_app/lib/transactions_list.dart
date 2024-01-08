import 'package:flutter/material.dart';
import 'package:yamm_app/filters.dart';
import 'package:yamm_app/functions/actions_on_list.dart';
import 'package:yamm_app/functions/preferences.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/functions/filter_transactions.dart';
import 'package:yamm_app/enum_types/category_enum.dart';
import 'package:yamm_app/user_preferences.dart';

enum DateFrames { year, month, day }

class TransactionsListsNotifier with ChangeNotifier {
  late ValueNotifier<List<Transaction>> transactionsList =
      ValueNotifier<List<Transaction>>(List<Transaction>.empty(growable: true));
  late ValueNotifier<List<Transaction>> dateFilteredTransactionsList =
      ValueNotifier<List<Transaction>>(List<Transaction>.empty(growable: true));
  late ValueNotifier<List<Transaction>> fieldFilteredTransactionsList =
      ValueNotifier<List<Transaction>>(List<Transaction>.empty(growable: true));
  late ValueNotifier<List<Transaction>> filteredTransactionsList =
      ValueNotifier<List<Transaction>>(List<Transaction>.empty(growable: true));
  late ValueNotifier<int> transactionsListId = ValueNotifier<int>(0);
  late ValueNotifier<Filters> filters = ValueNotifier<Filters>(Filters());

  ValueNotifier<DateFrames> dateFrame =
      ValueNotifier<DateFrames>(defaultDateFrame);

  void setList(List<Transaction> lst) {
    transactionsList.value = lst;
    filteredTransactionsList.value = lst;
    _filterListDate(lst);
    _filterListFields(lst);
    transactionsListId.value = getLastID(transactionsList.value);
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    transactionsList.value.add(transaction);
    filteredTransactionsList.value = transactionsList.value;
    transactionsListId.value = getLastID(transactionsList.value);
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  void setyearFromPicker(BuildContext context) async {}

  void deleteListItem(int id) {}

  void editListItem(int id, Transaction transaction) {}

  void _filterListDate(List<Transaction> lst) {
    switch (dateFrame.value) {
      case (DateFrames.year):
        {
          dateFilteredTransactionsList.value =
              filterListYear(lst, filters.value.yearFilter);
        }
      case (DateFrames.month):
        {
          dateFilteredTransactionsList.value =
              filterListYear(transactionsList.value, filters.value.yearFilter);
          dateFilteredTransactionsList.value = filterListMonth(
              dateFilteredTransactionsList.value, filters.value.monthFilter);
        }
      case (DateFrames.day):
        {
          dateFilteredTransactionsList.value =
              filterListYear(lst, filters.value.yearFilter);
          dateFilteredTransactionsList.value = filterListMonth(
              dateFilteredTransactionsList.value, filters.value.monthFilter);
          dateFilteredTransactionsList.value = filterListDay(
              dateFilteredTransactionsList.value, filters.value.dayFilter);
        }
    }
    notifyListeners();
  }

  void _filterListFields(List<Transaction> lst) {
    if (filters.value.filterCategories) {
      lst = filterListCategories(lst, filters.value.categoryFilters);
    }
    if (filters.value.filterLabels) {
      lst = filterListLabels(lst, filters.value.labelsFilters);
    }
    fieldFilteredTransactionsList.value = lst;
    notifyListeners();
  }

  void updateFilters({bool date = false, bool fields = false}) {
    if (date) {
      _filterListDate(transactionsList.value);
      _filterListFields(dateFilteredTransactionsList.value);
      filteredTransactionsList.value = fieldFilteredTransactionsList.value;
    } else if (fields) {
      _filterListFields(dateFilteredTransactionsList.value);
      filteredTransactionsList.value = fieldFilteredTransactionsList.value;
    }
    notifyListeners();
  }

  void setCategoryMap() {
    for (TransactionCategory category in TransactionCategory.values) {
      filters.value.categoryFilters[category] = false;
    }
    notifyListeners();
  }

  void toggleFilterCategories() {
    filters.value.filterCategories = !filters.value.filterCategories;
    notifyListeners();
  }

  void toggleFilterLabels() {
    filters.value.filterLabels = !filters.value.filterLabels;
    notifyListeners();
  }

  void toggleCategoryFilterVal(TransactionCategory category) {
    filters.value.categoryFilters[category] =
        !filters.value.categoryFilters[category]!;
    notifyListeners();
  }

  void setLabelsMap() async {
    getPreferencesList('labels').then((labels) => {
          for (String label in labels)
            {filters.value.labelsFilters[label] = false}
        });
    notifyListeners();
  }

  void toggleLabelFilterVal(String label) {
    filters.value.labelsFilters[label] = !filters.value.labelsFilters[label]!;
    notifyListeners();
  }
}
