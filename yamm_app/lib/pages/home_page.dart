import 'package:flutter/material.dart';
import 'package:yamm_app/home_page_list_show.dart';
import 'package:yamm_app/pages/add_Transaction.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/save_and_load_csv.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<Transaction> transactionsList = [
    Transaction(0),
    Transaction(1),
    Transaction(2),
  ];
  late Future<List<Transaction>> importedTransactionsList;
  late Future<int> transactionId;

  void reloadList() async {
    try {
      importedTransactionsList = readListFromCsv();
      setState(() {
        importedTransactionsList = importedTransactionsList;
        transactionId = getLastID(importedTransactionsList);
      });
    } catch (ex) {
      print(ex);
    }
  }

  @override
  initState() {
    super.initState();
    importedTransactionsList = readListFromCsv();
    transactionId = getLastID(importedTransactionsList);
  }

  @override
  Widget build(BuildContext context) {
    //final Future<List<Transaction>> lst = getFileData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Transaction>>(
          future: importedTransactionsList,
          initialData: transactionsList,
          // a previously-obtained Future<String> or null
          builder: (BuildContext context,
              AsyncSnapshot<List<Transaction>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData && snapshot.data != null) {
              List<Transaction> lst = snapshot.data!;
              children = <Widget>[
                Text("Has data ${lst[0].getAmount().toString()}"),
                HomePageList(transactionsList: snapshot.data)
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                ),
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FutureBuilder<int>(
        future: transactionId,

        // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          FloatingActionButton fab;
          if (snapshot.hasData && snapshot.data != null) {
            fab = FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTransaction(id: snapshot.data!)),
                ).then((data) {
                  // then will return value when the loginScreen's pop is called.
                  reloadList();
                });
              },
              tooltip: 'Add a transaction',
              child: const Icon(Icons.add),
            );
          } else {
            fab = FloatingActionButton(onPressed: () {});
          }
          return fab;
        },
      ),
    );
  }
}
