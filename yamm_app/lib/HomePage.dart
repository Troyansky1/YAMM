import 'package:flutter/material.dart';
import 'package:yamm_app/Transaction.dart';
import 'package:yamm_app/SaveAndLoadCsv.dart';
import 'package:yamm_app/SaveTransaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  //late List<List<dynamic>> employeeData;

  late List<List<dynamic>> transactionsList;
  late List<List<dynamic>> ImportedTransactionsList;

  List<Transaction> transactions = [
    Transaction(0, 'Generic super', 10),
    Transaction(1, 'Pharmacy', 20),
    Transaction(2, 'My clothing store', 100)
  ];

  @override
  initState() {
    ImportedTransactionsList = List<List<dynamic>>.empty(growable: true);
    transactionsList = List<List<dynamic>>.empty(growable: true);
    transactionsList = [
      Transaction(0, 'Generic super', 10).convertToListItem(),
      Transaction(1, 'Pharmacy', 20).convertToListItem(),
    ];

    () async {
      ImportedTransactionsList = await readListFromCsv();
      setState(() {
        ImportedTransactionsList = ImportedTransactionsList;
      });
    }();
  }

  List<Widget> getTextWidgets(List<dynamic> lst) {
    List<Widget> widgets = [];
    for (int i = 0; i < lst.length; i++) {
      // Includes all fields
      widgets.add(Text(lst[i].toString()));
    }
    return widgets;
  }

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              onPressed: () => writeListToCsv(transactionsList),
              child: const Text(
                "Save list",
                style: TextStyle(color: Colors.green),
              ),
            ),
            //The three buttons are for debug purposes.
            TextButton(
              onPressed: () async => {
                ImportedTransactionsList = await readListFromCsv(),
                setState(() {
                  ImportedTransactionsList = ImportedTransactionsList;
                })
              },
              child: const Text(
                "Load list",
                style: TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () => DeleteCsv(),
              child: const Text(
                "Delete list",
                style: TextStyle(color: Colors.green),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: ImportedTransactionsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            getTextWidgets(ImportedTransactionsList[index]),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        },
        tooltip: 'Add a transaction',
        child: const Icon(Icons.add),
      ),
    );
  }
}
