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
      currencyOptionsEntries.add(DropdownMenuItem<Currency>(
        value: currency,
        child: Image(
          image: AssetImage(symbolPath),
          height: 15,
          width: 15,
          fit: BoxFit.cover,
        ),
      ));
    }

    return Container(
        height: 30,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton2(
          //isExpanded: true,
          value: widget.controllers.currencyValue,
          buttonStyleData: const ButtonStyleData(
              width: 35, height: 30, padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
          dropdownStyleData: const DropdownStyleData(
            width: 45,
            maxHeight: 200,
            padding: EdgeInsets.only(),
            isOverButton: true,
          ),
          items: currencyOptionsEntries,
          onChanged: (Currency? value) {
            setState(() {
              widget.controllers.currencyValue = value!;
            });
          },
        )));
  }
}
