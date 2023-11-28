import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';

class amountEntry extends StatefulWidget {
  //final Widget child;
  final TransactionControllers controllers;
  const amountEntry(
      {super.key, required TransactionControllers this.controllers});

  @override
  State<amountEntry> createState() => _amountEntryState();
}

class _amountEntryState extends State<amountEntry> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Amount widget'),
      keyboardType: TextInputType.number,
      controller: widget.controllers.amountCont,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an amount.';
        } else if (value == 0) {
          return 'Amount must be bigger than 0';
        } else {
          double amount = double.parse(value);
          if (amount > 1000000) {
            return 'Amount is too big';
          }
        }
        return null;
      },
    );
  }
}
