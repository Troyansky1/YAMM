import 'package:yamm_app/transaction.dart';

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

List<Transaction> filterIncomeOutcome(List<Transaction> lst, bool outcome) {
  var inOutList = lst.where((e) => e.getIsOutcome() == outcome);
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
