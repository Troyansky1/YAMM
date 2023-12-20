import 'package:expandable_sliver_list/expandable_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/widgets/home_page_list_view/build_list_cards.dart';

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
      //Generates a message to let the user know that the list is empty
      String dateFrameStr = dateFrame.name.toString();
      return Text("No transactions in this $dateFrameStr");
    } else if (dateFrame == DateFrames.year) {
      //Shows a list of transactions inside a list of days inside a list of months from the given year.
      ExpandableSliverListController<List<Transaction>> controller =
          ExpandableSliverListController<List<Transaction>>(
              initialStatus: ExpandableSliverListStatus.expanded);
      return createTransactionsListYear(context, lst, controller);
    } else if (dateFrame == DateFrames.month) {
      //Shows a list of transactions inside a list of days from the given month.
      ExpandableSliverListController<List<Transaction>> controller =
          ExpandableSliverListController<List<Transaction>>(
              initialStatus: ExpandableSliverListStatus.expanded);
      int month = widget.transactionsListsNotifier.filters.value.monthFilter;
      return createTransactionsListMonth(
          context, lst, controller, false, month);
    } else if (dateFrame == DateFrames.day) {
      //Shows a list of transactions from the given day.
      ExpandableSliverListController<Transaction> controller =
          ExpandableSliverListController<Transaction>(
              initialStatus: ExpandableSliverListStatus.expanded);
      return createTransactionsListDay(context, lst, controller, false);
    } else {
      return const Text("Error");
    }
  }
}
