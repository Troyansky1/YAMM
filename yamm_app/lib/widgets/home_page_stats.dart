import 'package:flutter/material.dart';
import 'package:yamm_app/functions/calc_stats.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/transaction_type_enum.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/user_preferences.dart';

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

  Widget statsBox(String title, int amount, double width, Color numColor) {
    return SizedBox(
      width: width,
      height: 70,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
          Text(title),
          Text(
            amount.toString(),
            style: TextStyle(color: numColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Transaction> lst =
        widget.transactionsListsNotifier.filteredTransactionsList.value;
    double width = MediaQuery.of(context).size.width / 3 - 10;
    int balance = calcBalance(lst);
    int income = calcIncomesOutcomes(lst, TransactionType.income);
    int outcome = calcIncomesOutcomes(lst, TransactionType.outcome);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            statsBox("Total balance", balance, width, Colors.black),
            statsBox("Income", income, width, defaultIncomeColor),
            statsBox("Outcome", outcome, width, defaultOutcomeColor),
          ],
        ),
      ],
    );
  }
}
