import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/widgets/home_page_list_view/build_list_item.dart';
import 'package:expandable_sliver_list/expandable_sliver_list.dart';

Widget createTransactionsListMonth(
    BuildContext context,
    List<List<Transaction>> transactionListMonth,
    int month,
    ExpandableSliverListController<List<Transaction>> controller) {
  String monthName = DateFormat('MMMM').format(DateTime(0, month));
  return CustomScrollView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      slivers: [
        timeSwitch(controller, monthName),
        createTransactionsListMonthItem(
            context, transactionListMonth, month, controller)
      ]);
}

Widget createTransactionsListMonthItem(
    BuildContext context,
    List<List<Transaction>> transactionListMonth,
    int month,
    ExpandableSliverListController<List<Transaction>> controller) {
  if (transactionListMonth.isNotEmpty) {
    var dayControllers = genControllersPerDay();
    return ExpandableSliverList<List<Transaction>>(
        initialItems: transactionListMonth.toSet(),
        controller: controller,
        duration: const Duration(microseconds: 1),
        builder: (BuildContext context, transaction, int index) {
          return createTransactionsListDay(context, transactionListMonth[index],
              index, month, dayControllers[index]);
        });
  } else {
    return const SliverAppBar(); // Do not generate an empty list
  }
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
    int day,
    int month,
    ExpandableSliverListController<Transaction> controller) {
  if (transactionListDay.isNotEmpty) {
    return CustomScrollView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        slivers: [
          timeSwitch(controller, "$day.$month"),
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
      return BuildListItems.buildListItem(transactionListDay[index], context);
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
