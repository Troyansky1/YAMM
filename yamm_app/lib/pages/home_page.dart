import 'package:flutter/material.dart';
import 'package:yamm_app/Transaction.dart';
import 'package:yamm_app/save_and_load_csv.dart';
import 'package:yamm_app/pages/add_transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late List<List<dynamic>> transactionsList;
  late List<List<dynamic>> importedTransactionsList;
  late int transactionId = 0;

  List<Transaction> transactions = [
    Transaction.forDebug(0, 'Generic super', 10),
    Transaction.forDebug(1, 'Pharmacy', 20),
    Transaction.forDebug(2, 'My clothing store', 100)
  ];

  void reloadList() async {
    importedTransactionsList = await readListFromCsv();
    setState(() {
      importedTransactionsList = importedTransactionsList;
      transactionId = getLastID(importedTransactionsList);
    });
  }

  @override
  initState() {
    super.initState();
    importedTransactionsList = List<List<dynamic>>.empty(growable: true);
    transactionsList = List<List<dynamic>>.empty(growable: true);
    transactionsList = [
      Transaction.forDebug(0, 'Generic super', 10).convertToListItem(),
      Transaction.forDebug(1, 'Pharmacy', 20).convertToListItem(),
    ];
    // For debug
    if (importedTransactionsList == []) {
      writeListToCsv(transactionsList);
    }
    reloadList();
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
              onPressed: () => {
                deleteCsv(),
                reloadList(),
              },
              child: const Text(
                "Clear list",
                style: TextStyle(color: Colors.green),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: importedTransactionsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            getTextWidgets(importedTransactionsList[index]),
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
            MaterialPageRoute(
                builder: (context) => AddTransaction(id: transactionId)),
          ).then((data) {
            // then will return value when the loginScreen's pop is called.
            reloadList();
          });
          ;
        },
        tooltip: 'Add a transaction',
        child: const Icon(Icons.add),
      ),
    );
  }
}
