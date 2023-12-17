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
    Row serviceProviderRow = Row(
      children: <Widget>[Text(serviceProvider)],
    );
    return serviceProviderRow;
  }

  static Row buildDateRow(Transaction transaction) {
    DateTime date = transaction.getDate();
    String formattedDate = DateFormat('dd-MM-yy').format(date);
    Row dateRow = Row(children: <Widget>[Text(formattedDate)]);
    return dateRow;
  }

  static Row buildCategoryRow(Transaction transaction) {
    String categoryName = transaction.getCategory().name;
    List<String> labels = transaction.getLabels();
    List<Text> textLabels = labels
        .map((label) => label != "" ? Text(" #$label") : const Text(""))
        .toList();
    textLabels.insert(
        0,
        Text(
          categoryName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
    Row categoryRow = Row(children: textLabels);
    return categoryRow;
  }

  static Column buildEditColumn(Transaction transaction) {
    Column editColumn = const Column(children: <Widget>[
      Row(
        children: <Widget>[
          Icon(Icons.edit_note_rounded),
          Icon(Icons.delete_outlined)
        ],
      )
    ]);
    return editColumn;
  }

  static Column buildDataColumn(Transaction transaction) {
    List<Widget> rows = List<Widget>.empty(growable: true);
    rows.addAll([
      buildAmountRow(transaction),
      buildServiceProviderRow(transaction),
      buildDateRow(transaction),
      buildCategoryRow(transaction)
    ]);
    Column dataColumn =
        Column(mainAxisAlignment: MainAxisAlignment.start, children: rows);
    return dataColumn;
  }

  static Widget buildListItem(Transaction transaction) {
    List<Widget> columns = List<Widget>.empty(growable: true);
    columns
        .addAll([buildDataColumn(transaction), buildEditColumn(transaction)]);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columns,
        ),
      ),
    );
  }
}
