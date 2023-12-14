import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'package:yamm_app/transaction_entries/transaction_entries.dart';
import 'package:yamm_app/transactions_list.dart';

// Create a Form widget.
class TransactionEntryForm extends StatefulWidget {
  final int id;
  final TransactionsListsNotifier transactionsListsNotifier;
  const TransactionEntryForm(
      {super.key, required this.id, required this.transactionsListsNotifier});

  @override
  TransactionEntryFormState createState() {
    return TransactionEntryFormState();
  }
}

class TransactionEntryFormState extends State<TransactionEntryForm> {
  TransactionControllers controllers = TransactionControllers();
  final _formKey = GlobalKey<FormState>();

  late FocusNode myFocusNode;

  @override
  void initState() {
    controllers.initControllers();
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Aligns children to the top
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(5.0),
              ),
              AmountEntry(controllers: controllers),
              CurrencyEntry(controllers: controllers),
            ],
          ),

          ServiceProviderEntry(controllers: controllers),
          const EntriesPadding(),
          DateEntry(controllers: controllers),
          //const EntriesPadding(),
          //Does not have internal logic, but design is a thing.
          //repeatEntry(controllers: controllers),
          IncomeOutcomeEntry(controllers: controllers),
          CategoryEntry(controllers: controllers),
          LableEntry(controllers: controllers),
          const EntriesPadding(),
          SaveEntry(
            controllers: controllers,
            id: widget.id,
            formKey: _formKey,
            transactionsListsNotifier: widget.transactionsListsNotifier,
          )
        ],
      ),
    );
  }
}
