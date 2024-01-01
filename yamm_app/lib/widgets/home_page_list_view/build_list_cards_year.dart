import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/filters.dart';
import 'package:yamm_app/functions/filter_transactions.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/user_preferences.dart';
import 'package:yamm_app/widgets/home_page_list_view/build_transaction_list_item.dart';
import 'package:expandable_sliver_list/expandable_sliver_list.dart';

class BuildListCardsYear extends StatefulWidget {
  final TransactionsListsNotifier transactionsListsNotifier;
  final BuildContext context;

  BuildListCardsYear(
      {required this.context,
      required this.transactionsListsNotifier,
      super.key});

  @override
  State<BuildListCardsYear> createState() => _BuildListCardsYearState();
}

class _BuildListCardsYearState extends State<BuildListCardsYear> {
  late List<ExpandableSliverListController<List<Transaction>>> monthControllers;

  @override
  void initState() {
    monthControllers = genControllersPerMonth();
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in monthControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget createYearScrollView() {
    return CustomScrollView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        slivers: [
          createMonthSliverListItems(),
        ]);
  }

  Widget createMonthSliverListItems() {
    var transactionsListPerMonth = genListPerMonth(
        widget.transactionsListsNotifier.filteredTransactionsList.value);
    return SliverList.builder(
        itemCount: monthsPerYear,
        itemBuilder: (BuildContext context, int index) {
          int month = (monthsPerYear - index);
          ExpandableSliverListController<List<Transaction>>
              thisMonthController = monthControllers[month];
          var thisMonthTransactionList = transactionsListPerMonth[month];
          return createMonthScrollView(
              thisMonthTransactionList, thisMonthController, month);
        });
  }

  Widget createMonthScrollView(List<Transaction> transactionListMonth,
      ExpandableSliverListController<List<Transaction>> controller, int month) {
    String monthName = DateFormat('MMMM').format(DateTime(0, month));
    if (transactionListMonth.isNotEmpty) {
      return CustomScrollView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          slivers: [
            timeSwitchSliver(controller, monthName),
            createDayExpandableSliverListItem(
                transactionListMonth, controller, month)
          ]);
    } else {
      return Container();
    }
  }

  Widget createDayExpandableSliverListItem(
      List<Transaction> transactionListMonth,
      ExpandableSliverListController<List<Transaction>> controller,
      int month) {
    var transactionsListPerDay = genListPerDay(transactionListMonth);

    ExpandableSliverList<List<Transaction>> monthSliverList =
        ExpandableSliverList<List<Transaction>>(
      initialItems: transactionsListPerDay.reversed.toSet(),
      controller: controller,
      expandOnInitialInsertion: true,
      duration: defaultExpandDuration,
      builder: (BuildContext context, transactionsListDay, int index) {
        int day = (daysInMonth - index) % daysInMonth;
        return createDayScrollView(transactionsListDay, day: day, month: month);
      },
    );

    return monthSliverList;
  }

  Widget createDayScrollView(
    List<Transaction> transactionListDay, {
    int day = 0,
    int month = 0,
  }) {
    if (transactionListDay.isNotEmpty) {
      return CustomScrollView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("$day.$month",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  const Padding(padding: EdgeInsets.only(right: 23)),
                ],
              ),
            ),
            createTransactionsSliverItem(transactionListDay)
          ]);
    } else {
      return Container(); // Do not generate an empty list
    }
  }

  Widget createTransactionsSliverItem(
    List<Transaction> transactionListDay,
  ) {
    return SliverList.builder(
      itemCount: transactionListDay.length,
      itemBuilder: (BuildContext context, int index) {
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

  Widget timeSwitchSliver(
      ExpandableSliverListController controller, String titleVar,
      {String subtitleVar = ""}) {
    return SliverAppBar(
        title: Text(
          titleVar.toString(),
          style: const TextStyle(fontSize: 27),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.expand_less),
            isSelected: controller.isCollapsed(),
            selectedIcon: const Icon(Icons.expand_more),
            onPressed: () {
              _toggleController(controller);
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => setState(() {}));
            },
          )
        ]);
  }

  List<ExpandableSliverListController<List<Transaction>>>
      genControllersPerMonth() {
    List<ExpandableSliverListController<List<Transaction>>> controllersList =
        List<ExpandableSliverListController<List<Transaction>>>.empty(
            growable: true);
    for (int month = monthsPerYear; month >= 0; month--) {
      controllersList.add(ExpandableSliverListController<List<Transaction>>(
          initialStatus: ExpandableSliverListStatus.expanded));
    }
    return controllersList;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Filters>(
        valueListenable: widget.transactionsListsNotifier.filters,
        builder: (BuildContext context, Filters filters, Widget? child) {
          return createYearScrollView();
        });
  }
}
