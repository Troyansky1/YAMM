import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/functions/filter_transactions.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/widgets/home_page_list_view/build_transaction_list_item.dart';
import 'package:expandable_sliver_list/expandable_sliver_list.dart';

//TODO: Make this widgets a class

Widget createTransactionsListYear(
    BuildContext context,
    List<Transaction> transactionListYear,
    ExpandableSliverListController<List<Transaction>> controller) {
  if (transactionListYear.isNotEmpty) {
    return CustomScrollView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        slivers: [
          createTransactionsListYearItem(
              context, transactionListYear, controller)
        ]);
  } else {
    return const SizedBox();
  }
}

Widget createTransactionsListYearItem(
    BuildContext context,
    List<Transaction> transactionListYear,
    ExpandableSliverListController<List<Transaction>> controller) {
  var monthControllers = genControllersPerMonth();
  var transactionsListPerMonth = genListPerMonth(transactionListYear);
  return ExpandableSliverList<List<Transaction>>(
      initialItems: transactionsListPerMonth.toSet(),
      controller: controller,
      duration: const Duration(microseconds: 1),
      builder: (BuildContext context, transaction, int index) {
        return createTransactionsListMonth(
            context,
            transactionsListPerMonth[index],
            monthControllers[index],
            true,
            index);
      });
}

Widget createTransactionsListMonth(
    BuildContext context,
    List<Transaction> transactionListMonth,
    ExpandableSliverListController<List<Transaction>> controller,
    bool useSwitch,
    int month) {
  String monthName = DateFormat('MMMM').format(DateTime(0, month));
  if (transactionListMonth.isNotEmpty) {
    return CustomScrollView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        slivers: [
          if (useSwitch) timeSwitch(controller, monthName),
          createTransactionsListMonthItem(
              context, transactionListMonth, controller, month)
        ]);
  } else {
    return const SizedBox();
  }
}

Widget createTransactionsListMonthItem(
    BuildContext context,
    List<Transaction> transactionListMonth,
    ExpandableSliverListController<List<Transaction>> controller,
    int month) {
  var dayControllers = genControllersPerDay();
  var transactionsListPerDay = genListPerDay(transactionListMonth);
  return ExpandableSliverList<List<Transaction>>(
      initialItems: transactionsListPerDay.toSet(),
      controller: controller,
      duration: const Duration(microseconds: 1),
      builder: (BuildContext context, transaction, int index) {
        return createTransactionsListDay(
          context,
          transactionsListPerDay[index],
          dayControllers[index],
          true,
          day: index,
          month: month,
        );
      });
}

Widget timeSwitch(ExpandableSliverListController controller, String titleVar,
    {String subtitleVar = ""}) {
  return SliverToBoxAdapter(
    child: Container(
      alignment: Alignment.topLeft,
      height: 60,
      child: TextButton(
        child: Text(titleVar.toString()),
        onPressed: () {
          if (controller.isCollapsed()) {
            controller.expand();
          } else {
            controller.collapse();
          }
        },
      ),
    ),
  );
}

Widget createTransactionsListDay(
  BuildContext context,
  List<Transaction> transactionListDay,
  ExpandableSliverListController<Transaction> controller,
  bool useSwitch, {
  int day = 0,
  int month = 0,
}) {
  if (transactionListDay.isNotEmpty) {
    return CustomScrollView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        slivers: [
          if (useSwitch) timeSwitch(controller, "$day.$month"),
          createTransactionsListDayItem(context, transactionListDay, controller)
        ]);
  } else {
    return const SizedBox(); // Do not generate an empty list
  }
}

Widget createTransactionsListDayItem(
    BuildContext context,
    List<Transaction> transactionListDay,
    ExpandableSliverListController<Transaction> controller) {
  return ExpandableSliverList<Transaction>(
    initialItems: transactionListDay.toSet(),
    controller: controller,
    duration: const Duration(microseconds: 1),
    builder: (BuildContext context, transaction, int index) {
      return BuildTransactionListItems.buildListItem(
          transactionListDay[index], context);
    },
  );
}

// An horrific function that generates a list of controllers for each day of a month
List<ExpandableSliverListController<Transaction>> genControllersPerDay() {
  List<ExpandableSliverListController<Transaction>> controllersList =
      List<ExpandableSliverListController<Transaction>>.empty(growable: true);
  for (int day = 0; day <= 31; day++) {
    controllersList.add(ExpandableSliverListController<Transaction>(
        initialStatus: ExpandableSliverListStatus.expanded));
  }
  return controllersList;
}

List<ExpandableSliverListController<List<Transaction>>>
    genControllersPerMonth() {
  List<ExpandableSliverListController<List<Transaction>>> controllersList =
      List<ExpandableSliverListController<List<Transaction>>>.empty(
          growable: true);
  for (int day = 0; day <= 12; day++) {
    controllersList.add(ExpandableSliverListController<List<Transaction>>(
        initialStatus: ExpandableSliverListStatus.expanded));
  }
  return controllersList;
}
