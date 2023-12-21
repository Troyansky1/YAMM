import 'package:expandable_sliver_list/expandable_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:yamm_app/filters.dart';
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
  late BuildListCards buildListCards;
  late DateFrames dateFrame;
  late List<Transaction> lst;
  late Filters filters;

  @override
  void initState() {
    dateFrame = widget.transactionsListsNotifier.dateFrame.value;
    lst = widget.transactionsListsNotifier.filteredTransactionsList.value;
    filters = widget.transactionsListsNotifier.filters.value;

    widget.transactionsListsNotifier
        .addListener(() => mounted ? setState(() {}) : null);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dateFrame = widget.transactionsListsNotifier.dateFrame.value;
    lst = widget.transactionsListsNotifier.filteredTransactionsList.value;
    filters = widget.transactionsListsNotifier.filters.value;

    return BuildListCards(
        context: context,
        transactionsList: lst,
        dateFrame: dateFrame,
        filters: filters);
  }
}
