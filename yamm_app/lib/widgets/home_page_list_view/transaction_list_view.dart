import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yamm_app/filters.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/widgets/home_page_list_view/build_list_cards_day.dart';
import 'package:yamm_app/widgets/home_page_list_view/build_list_cards_month.dart';
import 'package:yamm_app/widgets/home_page_list_view/build_list_cards_year.dart';

class TransactionsListView extends StatefulWidget {
  final TransactionsListsNotifier transactionsListsNotifier;

  const TransactionsListView({
    super.key,
    required this.transactionsListsNotifier,
  });

  @override
  State<TransactionsListView> createState() => _TransactionsListViewState();
}

class _TransactionsListViewState extends State<TransactionsListView> {
  late DateFrames dateFrame;
  late List<Transaction> transactionsList;
  late Filters filters;
  late ValueListenable dateFrameListenable;

  @override
  void initState() {
    dateFrame = widget.transactionsListsNotifier.dateFrame.value;
    transactionsList =
        widget.transactionsListsNotifier.filteredTransactionsList.value;
    filters = widget.transactionsListsNotifier.filters.value;
    dateFrameListenable = widget.transactionsListsNotifier.dateFrame;
    widget.transactionsListsNotifier
        .addListener(() => mounted ? setState(() {}) : null);

    super.initState();
  }

  Widget showList(DateFrames dateFrame, List<Transaction> lst) {
    switch (dateFrame) {
      case DateFrames.year:
        {
          return BuildListCardsYear(
            transactionsListsNotifier: widget.transactionsListsNotifier,
            context: context,
          );
        }

      case DateFrames.month:
        {
          int month = filters.monthFilter;
          return BuildListCardsMonth(
              transactionsListsNotifier: widget.transactionsListsNotifier,
              context: context,
              month: month);
        }

      case DateFrames.day:
        {
          return BuildListCardsDay(
            context: context,
            transactionsListsNotifier: widget.transactionsListsNotifier,
          );
        }
      default:
        {
          return const Text("Error");
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    dateFrame = widget.transactionsListsNotifier.dateFrame.value;
    transactionsList =
        widget.transactionsListsNotifier.filteredTransactionsList.value;
    if (transactionsList.isNotEmpty) {
      setState(() {});
      return showList(dateFrame, transactionsList);
    } else {
      //Generates a message to let the user know that the list is empty
      String dateFrameStr = dateFrame.name.toString();
      return Text("No transactions in this $dateFrameStr");
    }
  }
}
