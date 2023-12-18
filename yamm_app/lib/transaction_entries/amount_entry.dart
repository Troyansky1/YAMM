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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Amount',
          contentPadding: EdgeInsets.symmetric(vertical: 2),
        ),
        keyboardType: TextInputType.number,
        controller: widget.controllers.amountCont,
        validator: (String? value) {
          var amount = toNum(value);
          if (amount == null) {
            return 'Enter a valid amount';
          } else if (amount == 0) {
            return 'Amount must be\nbigger than 0';
          } else if (amount > 1000000) {
            return 'Amount is too big';
          } else {
            return null;
          }
        },
        onSaved: (String? value) {},
      ),
    );
  }
}
