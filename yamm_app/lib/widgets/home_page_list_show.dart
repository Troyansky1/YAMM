import 'package:flutter/material.dart';
import 'package:yamm_app/functions/save_and_load_csv.dart';
import 'package:yamm_app/widgets/home_page_stats_show.dart';
import 'package:yamm_app/widgets/transaction_list/transaction_list_view.dart';
import 'package:yamm_app/widgets/home_page_filter_entries.dart';
import 'package:yamm_app/transactions_list.dart';

class HomePageList extends StatefulWidget {
  final TransactionsListsNotifier transactionsListsNotifier;
  const HomePageList({super.key, required this.transactionsListsNotifier});

  @override
  State<HomePageList> createState() => _HomePageListState();
}

class _HomePageListState extends State<HomePageList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        HomePageStats(
            transactionsListsNotifier: widget.transactionsListsNotifier),
        HomePageFilters(
            transactionsListsNotifier: widget.transactionsListsNotifier),
        const TextButton(onPressed: deleteCsv, child: Text("Clear list")),
        TransactionsListView(
          transactionsListsNotifier: widget.transactionsListsNotifier,
          month: DateTime.now().month,
        ),
      ],
    );
  }
}
