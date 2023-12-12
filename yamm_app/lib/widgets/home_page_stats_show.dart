import 'package:flutter/material.dart';
import 'package:yamm_app/functions/calc_stats.dart';
import 'package:yamm_app/functions/filter_transactions.dart';
import 'package:yamm_app/transaction.dart';

class HomePageStats extends StatefulWidget {
  final List<Transaction>? filterdTransactionsList;

  const HomePageStats({super.key, required this.filterdTransactionsList});

  @override
  State<HomePageStats> createState() => _HomePageStatsState();
}

class _HomePageStatsState extends State<HomePageStats> {
  int income = 0;
  int outcome = 0;
  int balance = 0;

  @override
  void initState() {
    super.initState();
    income = calcIncomesOutcomes(widget.filterdTransactionsList, false);
    outcome = calcIncomesOutcomes(widget.filterdTransactionsList, true);
    balance = calcBalance(widget.filterdTransactionsList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("Total balance: $balance Outcome: $outcome Income: $income")
      ],
    );
  }
}
