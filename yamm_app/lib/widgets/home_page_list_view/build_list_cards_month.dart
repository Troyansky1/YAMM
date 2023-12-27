import 'package:flutter/material.dart';
import 'package:yamm_app/filters.dart';
import 'package:yamm_app/functions/filter_transactions.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/user_preferences.dart';
import 'package:yamm_app/widgets/home_page_list_view/build_transaction_list_item.dart';
import 'package:expandable_sliver_list/expandable_sliver_list.dart';

class BuildListCardsMonth extends StatefulWidget {
  final TransactionsListsNotifier transactionsListsNotifier;
  final BuildContext context;

  final int month;

  BuildListCardsMonth(
      {required this.transactionsListsNotifier,
      required this.context,
      required this.month,
      super.key});

  @override
  State<BuildListCardsMonth> createState() => _BuildListCardsMonthState();
}

class _BuildListCardsMonthState extends State<BuildListCardsMonth> {
  Duration duration = const Duration(microseconds: 1);
  late List<ExpandableSliverListController<Transaction>> dayControllers;

  late List<List<Transaction>> transactionsListPerDay;

  @override
  void initState() {
    dayControllers = genControllersPerDay();
    transactionsListPerDay = genListPerDay(
        widget.transactionsListsNotifier.filteredTransactionsList.value);

    widget.transactionsListsNotifier
        .addListener(() => mounted ? setState(() {}) : null);

    super.initState();
  }

  @override
  void dispose() {
    for (var controller in dayControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void updateLists() {
    dayControllers = genControllersPerDay();
    transactionsListPerDay = genListPerDay(
        widget.transactionsListsNotifier.filteredTransactionsList.value);
  }

  Widget createMonthScrollView() {
    return CustomScrollView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        slivers: [createDaySliverItems()]);
  }

  Widget createDaySliverItems() {
    return SliverList.builder(
        itemCount: transactionsListPerDay.length,
        itemBuilder: (BuildContext context, int index) {
          return createDayScrollView(
            transactionsListPerDay[index],
            dayControllers[index],
            day: index,
          );
        });
  }

  Widget createDayScrollView(
    List<Transaction> transactionListDay,
    ExpandableSliverListController<Transaction> controller, {
    int day = 0,
  }) {
    if (transactionListDay.isNotEmpty) {
      return CustomScrollView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          slivers: [
            timeSwitchSliver(controller, "$day.${widget.month}"),
            createTransactionsExpandableSliverListItem(
                transactionListDay, controller)
          ]);
    } else {
      return Container(); // Do not generate an empty list
    }
  }

  Widget createTransactionsExpandableSliverListItem(
      List<Transaction> transactionListDay,
      ExpandableSliverListController<Transaction> controller) {
    ExpandableSliverList<Transaction> daySliverList =
        ExpandableSliverList<Transaction>(
      initialItems: transactionListDay.toSet(),
      controller: controller,
      expandOnInitialInsertion: true,
      duration: defaultExpandDuration,
      builder: (BuildContext context, transaction, int index) {
        return BuildTransactionListItems.buildListItem(transaction, context);
      },
    );

    return daySliverList;
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
        pinned: true,
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

  @override
  Widget build(BuildContext context) {
    transactionsListPerDay = genListPerDay(
        widget.transactionsListsNotifier.filteredTransactionsList.value);
    return ValueListenableBuilder<Filters>(
        valueListenable: widget.transactionsListsNotifier.filters,
        builder: (BuildContext context, Filters filters, Widget? child) {
          return createMonthScrollView();
        });
  }
}
