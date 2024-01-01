import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';

class AmountEntry extends StatefulWidget {
  //final Widget child;

  final TransactionControllers controllers;
  const AmountEntry({super.key, required this.controllers});

  @override
  State<AmountEntry> createState() => _AmountEntryState();
}

class _AmountEntryState extends State<AmountEntry> {
  num? toNum(String? s) {
    if (s == null || s.isEmpty) {
      return null;
    }
    return double.tryParse(s);
  }

  bool validNum(String? value) {
    var amount = toNum(value);
    if (amount == null) {
      return false;
    } else if (amount == 0) {
      return false;
    } else if (amount > 1000000) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: ' Amount',
        labelStyle: Theme.of(context).textTheme.titleMedium,
        contentPadding: EdgeInsets.symmetric(vertical: 1),
      ),
      keyboardType: TextInputType.number,
      controller: widget.controllers.amountCont,
      onSaved: (String? value) {},
    );
  }
}
