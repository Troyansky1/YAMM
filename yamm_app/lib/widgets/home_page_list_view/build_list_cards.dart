import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/filters.dart';
import 'package:yamm_app/functions/filter_transactions.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/widgets/home_page_list_view/build_transaction_list_item.dart';
import 'package:expandable_sliver_list/expandable_sliver_list.dart';
import 'dart:developer';

class BuildListCards extends StatefulWidget {
  final BuildContext context;
  final List<Transaction> transactionsList;
  final DateFrames dateFrame;
  final Filters filters;

  BuildListCards(
      {required this.context,
      required this.transactionsList,
      required this.dateFrame,
      required this.filters,
      super.key});

  @override
  State<BuildListCards> createState() => _BuildListCardsState();
}

class _BuildListCardsState extends State<BuildListCards> {
  ExpandableSliverListController<List<Transaction>> yearController =
      ExpandableSliverListController<List<Transaction>>(
    initialStatus: ExpandableSliverListStatus.expanded,
  );

  ExpandableSliverListController<List<Transaction>> monthController =
      ExpandableSliverListController<List<Transaction>>(
          initialStatus: ExpandableSliverListStatus.expanded);

  ExpandableSliverListController<Transaction> dayController =
      ExpandableSliverListController<Transaction>(
          initialStatus: ExpandableSliverListStatus.expanded);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget createTransactionsListYear() {
    if (widget.transactionsList.isNotEmpty) {
      return CustomScrollView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          slivers: [
            createTransactionsListYearItem(),
            SliverToBoxAdapter(
              child: Text(
                  "year controller has ${yearController.numItemsDisplayed()} items"),
            ),
          ]);
    } else {
      return const SizedBox();
    }
  }

  Widget createTransactionsListYearItem() {
    var monthControllers = genControllersPerMonth();
    var transactionsListPerMonth = genListPerMonth(widget.transactionsList);
    return ExpandableSliverList<List<Transaction>>(
        initialItems: transactionsListPerMonth.toSet(),
        controller: yearController,
        expandOnInitialInsertion: true,
        duration: const Duration(microseconds: 1),
        builder: (BuildContext context, transaction, int index) {
          ExpandableSliverListController<List<Transaction>>
              thisMonthController = monthControllers[index];
          return createTransactionsListMonth(transactionsListPerMonth[index],
              thisMonthController, true, index);
        });
  }

  Widget createTransactionsListMonth(
      List<Transaction> transactionListMonth,
      ExpandableSliverListController<List<Transaction>> controller,
      bool useSwitch,
      int month) {
    String monthName = DateFormat('MMMM').format(DateTime(0, month));
    log("Creating list month");
    log("$month controller has ${monthController.numItemsDisplayed()} items");
    if (transactionListMonth.isNotEmpty) {
      return CustomScrollView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          slivers: [
            timeSwitch(controller, monthName),
            const SliverToBoxAdapter(
              child: Text("month controller has  items"),
            ),
            createTransactionsListMonthItem(
                transactionListMonth, controller, month)
          ]);
    } else {
      return const SizedBox();
    }
  }

  Widget createTransactionsListMonthItem(List<Transaction> transactionListMonth,
      ExpandableSliverListController<List<Transaction>> controller, int month) {
    var dayControllers = genControllersPerDay();
    var transactionsListPerDay = genListPerDay(transactionListMonth);

    return ExpandableSliverList<List<Transaction>>(
        initialItems: transactionsListPerDay.toSet(),
        controller: controller,
        expandOnInitialInsertion: true,
        duration: const Duration(microseconds: 1),
        builder: (BuildContext context, transaction, int index) {
          return createTransactionsListDay(
            transactionsListPerDay[index],
            dayControllers[index],
            true,
            day: index,
            month: month,
          );
        });
  }

  Widget createTransactionsListDay(
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
            createTransactionsListDayItem(transactionListDay, controller)
          ]);
    } else {
      return Container(); // Do not generate an empty list
    }
  }

  Widget createTransactionsListDayItem(List<Transaction> transactionListDay,
      ExpandableSliverListController<Transaction> controller) {
    return ExpandableSliverList<Transaction>(
      initialItems: transactionListDay.toSet(),
      controller: controller,
      expandOnInitialInsertion: true,
      duration: const Duration(microseconds: 1),
      builder: (BuildContext context, transaction, int index) {
        return BuildTransactionListItems.buildListItem(
            transactionListDay[index], context);
      },
    );
  }

  void _toggleController(ExpandableSliverListController controller) {
    if (controller.isCollapsed()) {
      controller.expand();
    } else {
      controller.collapse();
    }
  }

  Widget timeSwitch(ExpandableSliverListController controller, String titleVar,
      {String subtitleVar = ""}) {
    return SliverAppBar(title: Text(titleVar.toString()), actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.expand_less),
        isSelected: controller.isCollapsed(),
        selectedIcon: const Icon(Icons.expand_more),
        onPressed: () {
          _toggleController(controller);
          //WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
        },
      )
    ]);
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

  @override
  Widget build(BuildContext context) {
    log("building");
    if (widget.transactionsList.isEmpty) {
      //Generates a message to let the user know that the list is empty
      String dateFrameStr = widget.dateFrame.name.toString();
      return Text("No transactions in this $dateFrameStr");
    } else if (widget.dateFrame == DateFrames.year) {
      //Shows a list of transactions inside a list of days inside a list of months from the given year.

      return createTransactionsListYear();
    } else if (widget.dateFrame == DateFrames.month) {
      //Shows a list of transactions inside a list of days from the given month.
      int month = widget.filters.monthFilter;
      return createTransactionsListMonth(
          widget.transactionsList, monthController, false, month);
    } else if (widget.dateFrame == DateFrames.day) {
      //Shows a list of transactions from the given day.
      return createTransactionsListDay(
          widget.transactionsList, dayController, false);
    } else {
      return const Text("Error");
    }
  }
}
