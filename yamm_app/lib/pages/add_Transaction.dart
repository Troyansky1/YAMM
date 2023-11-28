import 'package:flutter/material.dart';
import 'package:yamm_app/Transaction.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'package:yamm_app/widgets/transaction_entries/transaction_entries.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key, required this.id});
  final int id;
  final String title = "Add a transaction";

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  Transaction newTransaction = Transaction.forDebug(0, '', 100);
  TransactionControllers controllers = TransactionControllers();

  @override
  void initState() {
    controllers.initCOntrollers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Enter a transaction',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            amountEntry(controllers: controllers),
            serviceProviderEntry(controllers: controllers),
            dateEntry(controllers: controllers),
            //Does not have internal logic, but design is a thing.
            //repeatEntry(controllers: controllers),
            incomeOutcomeEntry(controllers: controllers),
            SaveEntry(controllers: controllers, id: widget.id)
          ],
        ),
      ),
    );
  }
}
