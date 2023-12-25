import 'package:flutter/material.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/widgets/transaction_form.dart';
import 'package:yamm_app/functions/back_dialog.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key, required this.transactionsListsNotifier});
  final TransactionsListsNotifier transactionsListsNotifier;
  final String title = "Add a transaction";

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            PopScope(
              canPop: false,
              onPopInvoked: (bool didPop) {
                if (didPop) {
                  return;
                }
                showBackDialog(context);
              },
              child: TextButton(
                onPressed: () {
                  showBackDialog(context);
                },
                child: const Text('Go back'),
              ),
            ),
            ValueListenableBuilder(
                valueListenable:
                    widget.transactionsListsNotifier.transactionsListId,
                builder: (BuildContext context, int id, Widget? child) {
                  return TransactionEntryForm(
                      id: id,
                      transactionsListsNotifier:
                          widget.transactionsListsNotifier);
                })
          ],
        ),
      ),
    );
  }
}
