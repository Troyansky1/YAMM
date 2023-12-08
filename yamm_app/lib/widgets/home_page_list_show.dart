import 'package:flutter/material.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/widgets/transaction_list/transaction_list_view.dart';

class HomePageList extends StatefulWidget {
  final List<Transaction>? transactionsList;
  const HomePageList({super.key, required this.transactionsList});

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
        const Text("to do stats"),
        const Text("to do filters"),
        TransactionsListView(
            transactionsList: widget.transactionsList,
            year: DateTime.now().year,
            month: DateTime.now().month),
      ],
    );
  }
}
