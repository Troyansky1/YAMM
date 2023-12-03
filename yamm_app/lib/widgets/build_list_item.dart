import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_fields_enum.dart';

void parseTransaction(List<dynamic> lst) {}

dynamic asEnumValue(List<dynamic> enumValues, int index) {
  try {
    return enumValues[index];
  } catch (err) {
    return null;
  }
}

List<Widget> getTextWidgets(List<dynamic> lst) {
  List<Widget> widgets = [];

  for (int i = 0; i < lst.length; i++) {
    TransactionEnum fieldValues = asEnumValue(TransactionEnum.values, i);
    if (fieldValues.showField) {
      String lstItem = lst[i].toString();
      String title = (fieldValues.showTitle ? fieldValues.title + (": ") : "");
      Icon icon = (fieldValues.showIcon ? fieldValues.icon : const Icon(null));

      // Includes all fields
      widgets.add(Row(children: <Widget>[icon, Text("$title $lstItem")]));
    }
  }
  return widgets;
}
