import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/user_preferences.dart';

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
    String formattedDate = DateFormat(transactionDateFormat).format(date);
    Row dateRow = Row(children: <Widget>[Text(formattedDate)]);
    return dateRow;
  }

  static Row buildCategoryRow(Transaction transaction) {
    String categoryName = transaction.getCategory().name;
    List<String> labels = transaction.getLabels();
    List<String> strLabels =
        labels.map((label) => label != "" ? " #$label" : "").toList();

    Text txt = Text(
      strLabels.join(),
      overflow: TextOverflow.clip,
      style: TextStyle(fontStyle: FontStyle.italic),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("$categoryName ", style: TextStyle(fontWeight: FontWeight.bold)),
        Flexible(
          child: txt,
        ),
      ],
    );
  }

  static Container buildEditContainer(Transaction transaction, double width) {
    Container editColumn = Container(
      width: width * 0.15,
      alignment: Alignment.centerRight,
      child: const Row(
        children: <Widget>[
          Icon(Icons.edit_note_rounded),
          Icon(Icons.delete_outlined)
        ],
      ),
    );

    return editColumn;
  }

  static Container buildDataContainer(Transaction transaction, double width) {
    List<Widget> rows = List<Widget>.empty(growable: true);
    rows.addAll([
      buildServiceProviderRow(transaction),
      buildAmountRow(transaction),

      //buildDateRow(transaction),
      buildCategoryRow(transaction)
    ]);
    return Container(
      width: width * 0.75,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: rows,
      ),
    );
  }

  static Widget buildListItem(Transaction transaction, double width) {
    List<Widget> columns = List<Widget>.empty(growable: true);
    columns.addAll([
      buildDataContainer(transaction, width),
      buildEditContainer(transaction, width)
    ]);
    return Container(
      width: width,
      height: 100,
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(),
        border: Border.all(
          width: 1,
        ),
      ),
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
