import 'package:expandable_sliver_list/expandable_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:yamm_app/functions/filter_transactions.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/widgets/home_page_list_view/build_list_cards_month.dart';

class TransactionsListView extends StatefulWidget {
  final TransactionsListsNotifier transactionsListsNotifier;
  final int month;

  const TransactionsListView(
      {super.key,
      required this.transactionsListsNotifier,
      required this.month});

  @override
  State<TransactionsListView> createState() => _TransactionsListViewState();
}

class _TransactionsListViewState extends State<TransactionsListView> {
  @override
  void initState() {
    super.initState();
    widget.transactionsListsNotifier
        .addListener(() => mounted ? setState(() {}) : null);
  }

  @override
  Widget build(BuildContext context) {
    DateFrames dateFrame = widget.transactionsListsNotifier.dateFrame.value;
    List<Transaction> lst =
        widget.transactionsListsNotifier.filteredTransactionsList.value;
    if (lst.isEmpty) {
      String dateFrameStr = dateFrame.name.toString();
      return Text("No transactions in this $dateFrameStr");
    } else if (dateFrame == DateFrames.month) {
      List<List<Transaction>> listOfDays = genListPerDay(
          widget.transactionsListsNotifier.filteredTransactionsList.value);
      ExpandableSliverListController<List<Transaction>> controller =
          ExpandableSliverListController<List<Transaction>>(
              initialStatus: ExpandableSliverListStatus.expanded);
      int month = widget.transactionsListsNotifier.filters.value.monthFilter;
      return createTransactionsListMonth(
          context, listOfDays, month, controller);
    } else if (dateFrame == DateFrames.day) {
      ExpandableSliverListController<Transaction> controller =
          ExpandableSliverListController<Transaction>(
              initialStatus: ExpandableSliverListStatus.expanded);
      int month = widget.transactionsListsNotifier.filters.value.monthFilter;
      int day = widget.transactionsListsNotifier.filters.value.dayFilter;
      return createTransactionsListDay(context, lst, day, month, controller);
    } else {
      return const Text("Error");
    }
  }
}
