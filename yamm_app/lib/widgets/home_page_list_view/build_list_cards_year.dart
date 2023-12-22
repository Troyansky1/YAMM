import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/filters.dart';
import 'package:yamm_app/functions/filter_transactions.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/widgets/home_page_list_view/build_transaction_list_item.dart';
import 'package:expandable_sliver_list/expandable_sliver_list.dart';

class BuildListCardsYear extends StatefulWidget {
  final TransactionsListsNotifier transactionsListsNotifier;
  final BuildContext context;
  final List<Transaction> transactionsList;

  BuildListCardsYear(
      {required this.context,
      required this.transactionsListsNotifier,
      required this.transactionsList,
      super.key});

  @override
  State<BuildListCardsYear> createState() => _BuildListCardsYearState();
}

class _BuildListCardsYearState extends State<BuildListCardsYear> {
  Duration duration = const Duration(microseconds: 1);
  late List<ExpandableSliverListController<List<Transaction>>> monthControllers;

  @override
  void initState() {
    monthControllers = genControllersPerMonth();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget createYearScrollView() {
    return CustomScrollView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        slivers: [
          createMonthExpandableSliverListItems(),
        ]);
  }

  Widget createMonthExpandableSliverListItems() {
    var transactionsListPerMonth = genListPerMonth(widget.transactionsList);
    return SliverList.builder(
        itemCount: transactionsListPerMonth.length,
        itemBuilder: (BuildContext context, int index) {
          ExpandableSliverListController<List<Transaction>>
              thisMonthController = monthControllers[index];
          var thisMonthTransactionList = transactionsListPerMonth[index];
          return createMonthScrollView(
              thisMonthTransactionList, thisMonthController, index);
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
            createDaySliverItems(transactionListMonth, controller, month)
          ]);
    } else {
      return Container();
    }
  }

  Widget createDaySliverItems(List<Transaction> transactionListMonth,
      ExpandableSliverListController<List<Transaction>> controller, int month) {
    var transactionsListPerDay = genListPerDay(transactionListMonth);

    return SliverList.builder(
        itemCount: transactionsListPerDay.length,
        itemBuilder: (BuildContext context, int index) {
          return createDayScrollView(
            transactionsListPerDay[index],
            day: index,
            month: month,
          );
        });
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
            Text("$day.$month",
                style: const TextStyle(fontWeight: FontWeight.bold)),
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
    return SliverAppBar(title: Text(titleVar.toString()), actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.expand_less),
        isSelected: controller.isCollapsed(),
        selectedIcon: const Icon(Icons.expand_more),
        onPressed: () {
          _toggleController(controller);
          WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
        },
      )
    ]);
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
    return ValueListenableBuilder<Filters>(
        valueListenable: widget.transactionsListsNotifier.filters,
        builder: (BuildContext context, Filters filters, Widget? child) {
          return createYearScrollView();
        });
  }
}
