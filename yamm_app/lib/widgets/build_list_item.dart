import 'package:flutter/material.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/transaction_fields_enum.dart';

void parseTransaction(List<dynamic> lst) {}

dynamic asEnumValue(List<dynamic> enumValues, int index) {
  try {
    return enumValues[index];
  } catch (err) {
    return null;
  }
}

List<Widget> getTextWidgets(Transaction transaction) {
  List<Widget> widgets = List<Widget>.empty(growable: true);
  String amount = transaction.getAmountString();
  TextStyle amountStyle = TextStyle();
  String serviceProvider = transaction.getServiceProvider();
  bool outcome = transaction.getIsOutcome();
  String currencySymbolPath = transaction.getCurrency().symbolPath;
  Image currencySymbol = Image(
    image: AssetImage(currencySymbolPath),
    height: 10,
    width: 10,
  );

  if (outcome) {
    amountStyle = TextStyle(color: Color.fromARGB(255, 179, 65, 4));
  } else {
    amountStyle = TextStyle(color: Colors.green[900]);
  }
  Row amountRow = Row(children: <Widget>[
    Text(
      "$amount ",
      style: amountStyle,
    ),
    currencySymbol
  ]);

  Row serviceProviderRow = Row(children: <Widget>[Text("$serviceProvider")]);

  widgets.addAll([amountRow, serviceProviderRow]);

  return widgets;
}
