import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/transaction.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yamm_app/enum_types/transaction_type_enum.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/user_preferences.dart';

class BuildTransactionListItems extends StatefulWidget {
  final int index;
  final Transaction transaction;
  final TransactionsListsNotifier transactionsListsNotifier;
  final BuildContext context;
  const BuildTransactionListItems(
      {super.key,
      required this.transactionsListsNotifier,
      required this.transaction,
      required this.index,
      required this.context});

  @override
  State<BuildTransactionListItems> createState() =>
      _BuildTransactionListItemsState();
}

class _BuildTransactionListItemsState extends State<BuildTransactionListItems> {
  static Container buildAmountContainer(Transaction transaction, double width) {
    String amount = transaction.getAmountString();
    TextStyle amountStyle = const TextStyle();
    TransactionType transactionType = transaction.getTransactionType();
    String amountPrefix = "";
    String currencySymbolPath = transaction.getCurrency().symbolPath;
    Image currencySymbol = Image(
      image: AssetImage(currencySymbolPath),
      height: 10,
      width: 10,
    );

    if (transactionType == TransactionType.income) {
      amountPrefix = '+';
      amountStyle = TextStyle(color: defaultIncomeColor);
    } else {
      amountPrefix = '-';
      amountStyle = TextStyle(color: defaultOutcomeColor);
    }
    Container amountContainer = Container(
        width: width * 0.25,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Text(
            "$amountPrefix$amount ",
            style: amountStyle,
          ),
          currencySymbol
        ]));

    return amountContainer;
  }

  static Row buildServiceProviderRow(Transaction transaction) {
    String serviceProvider = transaction.getServiceProvider();
    Row serviceProviderRow = Row(
      children: <Widget>[
        Text(serviceProvider,
            style:
                GoogleFonts.dosis(fontSize: 20, fontWeight: FontWeight.w500)),
      ],
    );
    return serviceProviderRow;
  }

  static Row buildNotesRow(Transaction transaction) {
    String notes = transaction.getDetails();
    Row notesRow = Row(
      children: <Widget>[
        Text(notes,
            style:
                GoogleFonts.dosis(fontSize: 15, fontWeight: FontWeight.w500)),
      ],
    );
    return notesRow;
  }

  static Row buildDebugRow(Transaction transaction) {
    DateTime date = transaction.getDate();
    int id = transaction.getId();
    int subId = transaction.getSubId();
    String formattedDate = DateFormat(presentDateFormat).format(date);
    Row dateRow = Row(children: <Widget>[
      Text(
          "date: $formattedDate   id: ${id.toString()}   sub id: ${subId.toString()}")
    ]);
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
      style: const TextStyle(fontStyle: FontStyle.italic),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("$categoryName "),
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

  static Container buildDetailsContainer(
      Transaction transaction, double width) {
    List<Widget> rows = List<Widget>.empty(growable: true);
    rows.addAll([
      buildServiceProviderRow(transaction),
      buildNotesRow(transaction),
      //buildDebugRow(transaction),
      buildCategoryRow(transaction)
    ]);
    return Container(
      width: width * 0.7,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: rows,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columns = List<Widget>.empty(growable: true);
    double width = MediaQuery.of(context).size.width;
    columns.addAll([
      buildDetailsContainer(widget.transaction, width),
      buildAmountContainer(widget.transaction, width),
      //buildEditContainer(widget.transaction, width)
    ]);
    return Dismissible(
        key: UniqueKey(),
        secondaryBackground: Container(
            alignment: Alignment.centerRight,
            color: const Color.fromARGB(255, 196, 77, 68),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Icon(Icons.delete),
            )),
        background: Container(
            alignment: Alignment.centerLeft,
            color: Color.fromARGB(255, 138, 135, 135),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Icon(Icons.edit),
            )),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            setState(() {
              widget.transactionsListsNotifier
                  .removeTransaction(widget.transaction, context);
            });
          } else if (direction == DismissDirection.startToEnd) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Currently can't edit, please refresh")));
          }
        },
        child: Container(
          width: width,
          foregroundDecoration: BoxDecoration(
            borderRadius: const BorderRadius.horizontal(),
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
        ));
  }
}
