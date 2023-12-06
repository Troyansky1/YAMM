import 'package:flutter/material.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/widgets/build_list_item.dart';

class TransactionsListCards extends StatefulWidget {
  final List<Transaction> transactionList;
  final int day;
  final int month;
  const TransactionsListCards(
      {super.key,
      required this.transactionList,
      required this.day,
      required this.month});

  @override
  State<TransactionsListCards> createState() => _TransactionsListCardsState();
}

class _TransactionsListCardsState extends State<TransactionsListCards> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int day = widget.day;
    int month = widget.month;
    if (widget.transactionList.isNotEmpty) {
      return Card(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              title: Text('$day.$month'),
              dense: true,
            ),
            const Divider(),
            ListView.builder(
              itemCount: widget.transactionList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return BuildListItems.buildListItem(
                    widget.transactionList[index]);
              },
            ),
          ],
        ),
      );
    } else {
      return Text("empty day");
    }
  }
}
