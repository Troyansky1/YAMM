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
    String buttonText = widget.controllers.transactionType.value.name;
    return TextButton.icon(
        icon: const Icon(Icons.repeat),
        label: Text(buttonText),
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.only(
                  left: 0, right: 10), // Adjust the left padding as needed
            ),
            alignment: Alignment.centerLeft,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.elliptical(10, 10),
                  right: Radius.elliptical(10, 10)),
            ))),
        onPressed: () {
          setState(() {
            widget.controllers.transactionType.value = TransactionType.getNext(
                widget.controllers.transactionType.value);
            buttonText = widget.controllers.transactionType.value.name;
            widget.controllers.notify();
          });
        });
  }
}
