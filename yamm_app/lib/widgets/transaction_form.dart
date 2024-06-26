import 'package:flutter/material.dart';
import 'package:yamm_app/add_transaction_fields_view/view_date.dart';
import 'package:yamm_app/add_transaction_fields_view/view_payment_method.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'package:yamm_app/add_transaction_fields_view/view_labels.dart';
import 'package:yamm_app/transaction_entries/notes_entry.dart';
import 'package:yamm_app/transaction_entries/transaction_entries.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/user_preferences.dart';

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
    controllers.initControllers(widget.id);
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
        child: Padding(
          padding: const EdgeInsetsDirectional.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Aligns children to the top

                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 70, 0, 0),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                    width: 80,
                    child: AmountEntry(controllers: controllers),
                  ),
                  CurrencyEntry(controllers: controllers),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                    width: 40,
                    child: BottomSheetChipSelect(
                        chosenItemsList: controllers.paymentMethods,
                        updatevalue: controllers.notify,
                        replaceWhenEnterNew: true,
                        optionsListName: 'paymentMethods',
                        button: const Icon(Icons.edit),
                        maxSelect: 1),
                  ),
                  PaymentMethodChoice(transactionControllers: controllers),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Aligns children to the top
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.fromLTRB(10, 70, 0, 0)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                    width: 250,
                    child: ServiceProviderEntry(controllers: controllers),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Aligns children to the top
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.fromLTRB(10, 70, 0, 0)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: NotesEntry(controllers: controllers),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.fromLTRB(10, 40, 0, 0)),
                  ViewDate(controllers: controllers),
                  DateEntry(controllers: controllers),
                ],
              ),
              //const EntriesPadding(),
              //Does not have internal logic, but design is a thing.
              //repeatEntry(controllers: controllers),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.fromLTRB(5, 50, 0, 0)),
                  SizedBox(
                    width: 100,
                    child: IncomeOutcomeEntry(controllers: controllers),
                  )
                ],
              ),

              //LableEntry(controllers: controllers),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Aligns children to the top
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(5, 70, 0, 0),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: 115,
                    alignment: Alignment.centerLeft,
                    child: CategoryEntry(controllers: controllers),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: 115,
                    alignment: Alignment.centerLeft,
                    child: BottomSheetChipSelect(
                        chosenItemsList: controllers.labels,
                        updatevalue: controllers.notify,
                        replaceWhenEnterNew: false,
                        optionsListName: 'labels',
                        button: const Text("Add labels"),
                        maxSelect: defaultMaxLabels),
                  ),
                ],
              ),
              ShowChosenLabels(transactionControllers: controllers),
              const EntriesPadding(),
              SaveEntry(
                controllers: controllers,
                id: widget.id,
                formKey: _formKey,
                transactionsListsNotifier: widget.transactionsListsNotifier,
              )
            ],
          ),
        ));
  }
}
