import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/transaction.dart';

class BuildListItems {
  BuildListItems();

  static Row buildAmountRow(Transaction transaction) {
    String amount = transaction.getAmountString();
    TextStyle amountStyle = const TextStyle();
    bool outcome = transaction.getIsOutcome();
    String amountPrefix = "";
    String currencySymbolPath = transaction.getCurrency().symbolPath;
    Image currencySymbol = Image(
      image: AssetImage(currencySymbolPath),
      height: 10,
      width: 10,
    );

    if (outcome) {
      amountPrefix = ' ';
      amountStyle = TextStyle(color: Colors.grey[800]);
    } else {
      amountPrefix = '+';
      amountStyle = TextStyle(color: Colors.green[700]);
    }
    Row amountRow = Row(children: <Widget>[
      Text(
        "$amountPrefix$amount ",
        style: amountStyle,
      ),
      currencySymbol
    ]);

    return amountRow;
  }

  static Row buildServiceProviderRow(Transaction transaction) {
    String serviceProvider = transaction.getServiceProvider();
    Row serviceProviderRow = Row(children: <Widget>[Text(serviceProvider)]);
    return serviceProviderRow;
  }

  static Row buildDateRow(Transaction transaction) {
    DateTime date = transaction.getDate();
    String formattedDate = DateFormat('dd-MM-yy').format(date);
    Row dateRow = Row(children: <Widget>[Text(formattedDate)]);
    return dateRow;
  }

  static Widget buildListItem(Transaction transaction) {
    List<Widget> rows = List<Widget>.empty(growable: true);
    rows.addAll(
        [buildAmountRow(transaction), buildServiceProviderRow(transaction)]);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rows,
        ),
      ),
    );
  }
}
