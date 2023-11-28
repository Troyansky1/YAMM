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
  double? toDouble(String? s) {
    if (s == null || s.isEmpty) {
      return null;
    }
    return double.tryParse(s);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: 'Amount widget'),
      keyboardType: TextInputType.number,
      controller: widget.controllers.amountCont,
      validator: (String? value) {
        var amount = toDouble(value);
        if (amount == null) {
          return 'Enter a valid amount';
        } else if (amount == 0) {
          return 'Amount must be bigger than 0';
        } else if (amount > 1000000) {
          return 'Amount is too big';
        } else {
          return null;
        }
      },
      onSaved: (String? value) {},
    );
  }
}
