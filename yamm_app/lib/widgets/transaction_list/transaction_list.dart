import 'package:flutter/material.dart';
import 'package:yamm_app/transaction.dart';

class TransactionsList extends StatefulWidget {
  final List<Transaction> transactionsList = [];
  TransactionsList({super.key, required List<Transaction> transactionsList});

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text('List ${widget.transactionsList[0]}'),
          ),
          Divider(),
          ListView.builder(
            itemCount: widget.transactionsList.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.transactionsList[index].notes),
              );
            },
          ),
        ],
      ),
    );
  }
}
