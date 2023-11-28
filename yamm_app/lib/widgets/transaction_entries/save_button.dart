import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'package:yamm_app/save_and_load_csv.dart';

class SaveEntry extends StatefulWidget {
  //final Widget child;
  final TransactionControllers controllers;
  final int id;
  const SaveEntry({super.key, required this.controllers, required this.id});

  @override
  State<SaveEntry> createState() => _SaveEntryState();
}

class _SaveEntryState extends State<SaveEntry> {
  void varifyAndSaveTransaction(id) {
    List<dynamic> transactionToSave;
    transactionToSave = widget.controllers.buildTransactionItem(id);
    AppendItemToCsv(transactionToSave);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () =>
          {varifyAndSaveTransaction(widget.id), Navigator.pop(context)},
      //writeListToCsv(),
      child: const Text(
        "Save!",
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
