import 'package:flutter/material.dart';
import 'package:yamm_app/functions/calc_stats.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/transactions_list.dart';

class HomePageStats extends StatefulWidget {
  final TransactionsListsNotifier transactionsListsNotifier;

  const HomePageStats({super.key, required this.transactionsListsNotifier});

  @override
  State<HomePageStats> createState() => _HomePageStatsState();
}

class _HomePageStatsState extends State<HomePageStats> {
  ValueNotifier<int> income = ValueNotifier(0);
  ValueNotifier<int> outcome = ValueNotifier(0);
  ValueNotifier<int> balance = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    widget.transactionsListsNotifier
        .addListener(() => mounted ? setState(() {}) : null);
  }

  @override
  Widget build(BuildContext context) {
    List<Transaction> lst =
        widget.transactionsListsNotifier.transactionsList.value;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Text("Total balance: "),
            Text("${calcBalance(lst)}  "),
            const Text("Income: "),
            Text("${calcIncomesOutcomes(lst, false)}  "),
            const Text("Outcome: "),
            Text("${calcIncomesOutcomes(lst, true)}  "),
          ],
        ),
      ],
    );
  }
}
