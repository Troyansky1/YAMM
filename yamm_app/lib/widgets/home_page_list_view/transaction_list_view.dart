import 'package:flutter/material.dart';
import 'package:yamm_app/functions/filter_transactions.dart';
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
    List<Transaction> lst =
        widget.transactionsListsNotifier.filteredTransactionsList.value;
    if (lst.isEmpty) {
      String dateFrameStr =
          widget.transactionsListsNotifier.dateFrame.value.name.toString();
      return Text("No transactions in this $dateFrameStr");
    } else {
      List<List<Transaction>> listToShow = genListPerDay(
          widget.transactionsListsNotifier.filteredTransactionsList.value);

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
