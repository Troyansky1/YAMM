import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'package:yamm_app/save_and_load_csv.dart';

class SaveEntry extends StatefulWidget {
  //final Widget child;
  final TransactionControllers controllers;
  final int id;
  final GlobalKey<FormState> formKey;
  const SaveEntry(
      {super.key,
      required this.controllers,
      required this.id,
      required this.formKey});

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
      List<dynamic> transactionToSave;
      transactionToSave = widget.controllers.buildTransactionItem(id);
      AppendItemToCsv(transactionToSave);
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
