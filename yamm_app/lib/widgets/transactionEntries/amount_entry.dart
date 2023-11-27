import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/transaction_controllers.dart';

class amountEntry extends StatefulWidget {
  final Widget child;
  final TransactionControllers controllers;
  const amountEntry(
      {super.key,
      required TransactionControllers this.controllers,
      required Widget this.child});

  @override
  State<amountEntry> createState() => _amountEntryState();
}

class _amountEntryState extends State<amountEntry> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Amount'),
      keyboardType: TextInputType.number,
      controller: widget.controllers.amountCont,
    );
  }
}
