import 'package:flutter/material.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'package:yamm_app/functions/save_and_load_csv.dart';
import 'package:yamm_app/transactions_list.dart';

class SaveEntry extends StatefulWidget {
  //final Widget child;
  final TransactionControllers controllers;
  final int id;
  final GlobalKey<FormState> formKey;
  final TransactionsListsNotifier transactionsListsNotifier;
  const SaveEntry(
      {super.key,
      required this.controllers,
      required this.id,
      required this.formKey,
      required this.transactionsListsNotifier});

  @override
  State<SaveEntry> createState() => _SaveEntryState();
}

class _SaveEntryState extends State<SaveEntry> {
  void varifyAndSaveTransaction(id, formKey) {
    if (formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      Transaction transaction = widget.controllers.setTransaction(id);
      List<dynamic> transactionListItem;
      transactionListItem =
          widget.controllers.buildTransactionListItem(transaction);
      widget.controllers.updateLists().then((value) {
        widget.transactionsListsNotifier.setLabelsMap();
      });

      appendItemToCsv(transactionListItem);
      widget.transactionsListsNotifier.addTransaction(transaction);

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fix the data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {
        varifyAndSaveTransaction(widget.id, widget.formKey),
      },
      //writeListToCsv(),
      child: const Text(
        "Save!",
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
