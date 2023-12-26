import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'package:yamm_app/transaction_type_enum.dart';

class IncomeOutcomeEntry extends StatefulWidget {
  //final Widget child;
  final TransactionControllers controllers;
  const IncomeOutcomeEntry({super.key, required this.controllers});

  @override
  State<IncomeOutcomeEntry> createState() => _IncomeOutcomeEntryState();
}

class _IncomeOutcomeEntryState extends State<IncomeOutcomeEntry> {
  @override
  Widget build(BuildContext context) {
    String buttonText = widget.controllers.transactionType.name;
    return TextButton.icon(
        icon: const Icon(Icons.repeat),
        label: Text(buttonText),
        onPressed: () {
          setState(() {
            widget.controllers.transactionType =
                TransactionType.getNext(widget.controllers.transactionType);
            buttonText = widget.controllers.transactionType.name;
          });
        });
  }
}
