import 'package:flutter/material.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/transaction_controllers.dart';
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
  void saveTransaction(Transaction transaction, int id, int subId) {}

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {
        widget.controllers
            .onSave(context, widget.formKey, widget.transactionsListsNotifier),
      },
      child: const Text(
        "Save!",
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
