import 'package:yamm_app/category_enum.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/transaction_type_enum.dart';

List<Transaction> filterListCategories(
    List<Transaction> lst, Map<TransactionCategory, bool> categoryFilters) {
  List<TransactionCategory> categories =
      categoryFilters.keys.where((e) => categoryFilters[e] == true).toList();
  List<Transaction> categoriesFilteredList =
      lst.where((e) => categories.contains(e.getCategory())).toList();
  return categoriesFilteredList;
}

List<Transaction> filterListLabels(
    List<Transaction> lst, Map<String, bool> labelFilters) {
  Set<String> labels =
      labelFilters.keys.where((e) => labelFilters[e] == true).toSet();
  List<Transaction> labelsFilteredList = lst
      .where((e) => labels.intersection(e.getLabels().toSet()).isNotEmpty)
      .toList();
  return labelsFilteredList;
}

List<Transaction> filterListYear(List<Transaction> lst, int year) {
  var yearList = lst.where((e) => e.getDate().year == year);
  return yearList.toList();
}

List<Transaction> filterListMonth(List<Transaction> lst, int month) {
  var monthList = lst.where((e) => e.getDate().month == month);
  return monthList.toList();
}

List<Transaction> filterListDay(List<Transaction> lst, int day) {
  var dayList = lst.where((e) => e.getDate().day == day);
  return dayList.toList();
}

List<Transaction> filterIncomeOutcome(
    List<Transaction> lst, TransactionType transactionType) {
  var inOutList = lst.where((e) => e.getTransactionType() == transactionType);
  return inOutList.toList();
}

List<Transaction> sortList(List<Transaction> lst) {
  List<Transaction> sortedList = lst;
  sortedList.sort((a, b) => a.getDate().compareTo(b.getDate()));
  return sortedList;
}

List<List<Transaction>> genListPerDay(List<Transaction> lst) {
  lst = sortList(lst);
  List<List<Transaction>> listOfLists =
      List<List<Transaction>>.empty(growable: true);
  for (int day = 0; day <= 31; day++) {
    listOfLists.add(filterListDay(lst, day));
  }
  return listOfLists;
}

List<List<Transaction>> genListPerMonth(List<Transaction> lst) {
  lst = sortList(lst);
  List<List<Transaction>> listOfLists =
      List<List<Transaction>>.empty(growable: true);
  for (int month = 0; month <= 12; month++) {
    List<Transaction> monthList = filterListMonth(lst, month);
    listOfLists.add(monthList);
  }
  return listOfLists;
}
