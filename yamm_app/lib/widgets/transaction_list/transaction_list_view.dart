import 'package:flutter/material.dart';
import 'package:yamm_app/functions/filter_transactions.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/widgets/transaction_list/build_list_cards.dart';

class TransactionsListView extends StatefulWidget {
  final List<Transaction>? transactionsList;
  final int month;

  const TransactionsListView(
      {super.key, required this.transactionsList, required this.month});

  @override
  State<TransactionsListView> createState() => _TransactionsListViewState();
}

class _TransactionsListViewState extends State<TransactionsListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.transactionsList == null) {
      return const Text("No transactions in this month");
    } else {
      List<Transaction> transactionsList = widget.transactionsList!;
      List<List<Transaction>> listToShow = genListPerDay(transactionsList);

      return ListView.builder(
          itemCount: listToShow.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return TransactionsListCards(
                transactionList: listToShow[index],
                day: index,
                month: widget.month);
          });
    }
  }
}
