import 'package:flutter/material.dart';
import 'package:yamm_app/AddTransaction.dart';
import 'package:yamm_app/SaveTransaction.dart';
import 'package:yamm_app/Transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<Transaction> transactions = [
    Transaction(0, 'Generic super', 10),
    Transaction(1, 'Pharmacy', 20),
    Transaction(2, 'My clothing store', 100)
  ];

  void newTransaction(Transaction transaction) {
    setState(() {
      transactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (BuildContext context, int index) {
            var transaction = transactions[index];
            return Card(
                child: Row(
              children: <Widget>[
                Expanded(
                    child: ListTile(
                  title: Text(transaction.serviceProvider),
                  subtitle: Text(transaction.amount.toString()),
                )),
                Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () => {}, icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () => {}, icon: const Icon(Icons.delete)),
                  ],
                )
              ],
            ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        },
        tooltip: 'Add a transaction',
        child: const Icon(Icons.add),
      ),
    );
  }
}
