import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'package:yamm_app/widgets/transaction_entries/transaction_entries.dart';

// Create a Form widget.
class TransactionEntryForm extends StatefulWidget {
  final int id;
  const TransactionEntryForm({super.key, required this.id});

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
          amountEntry(controllers: controllers),
          EntriesPadding(),
          serviceProviderEntry(controllers: controllers),
          EntriesPadding(),
          dateEntry(controllers: controllers),
          EntriesPadding(),
          //Does not have internal logic, but design is a thing.
          //repeatEntry(controllers: controllers),
          //EntriesPadding(),
          incomeOutcomeEntry(controllers: controllers),
          EntriesPadding(),
          SaveEntry(controllers: controllers, id: widget.id, formKey: _formKey)
        ],
      ),
    );
  }
}