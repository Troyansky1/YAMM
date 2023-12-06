import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'package:yamm_app/user_preferences.dart';
import 'package:yamm_app/currency_enum.dart';

class CurrencyEntry extends StatefulWidget {
  //final Widget child;
  final TransactionControllers controllers;
  const CurrencyEntry({super.key, required this.controllers});

  @override
  State<CurrencyEntry> createState() => _CurrencyEntryState();
}

class _CurrencyEntryState extends State<CurrencyEntry> {
  Currency dropdownValue = defaultCurrency;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<Currency>> currencyOptionsEntries =
        <DropdownMenuItem<Currency>>[];
    for (final Currency currency in Currency.values) {
      String symbolPath = currency.symbolPath;
      currencyOptionsEntries.add(
        DropdownMenuItem<Currency>(
            value: currency,
            child: Image(
              image: AssetImage(symbolPath),
              height: 14,
              width: 14,
            )),
      );
    }

    return Column(
      children: <Widget>[
        SizedBox(
            height: 50,
            width: 70,
            child: DropdownButton2<Currency>(
              value: widget.controllers.currencyValue,
              style: const TextStyle(color: Colors.deepPurple),
              alignment: AlignmentDirectional.center,
              items: currencyOptionsEntries,
              onChanged: (Currency? value) {
                setState(() {
                  widget.controllers.currencyValue = value!;
                });
              },
            ))
      ],
    );
  }
}
