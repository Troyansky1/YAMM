import 'package:flutter/material.dart';
import 'package:yamm_app/widgets/home_page_list_show.dart';
import 'package:yamm_app/pages/add_Transaction.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/functions/save_and_load_csv.dart';
import 'package:yamm_app/transactions_list.dart';

/*
class HomePage2 extends StatefulWidget {
  const HomePage2({super.key, required this.title});
  final String title;

  @override
  State<HomePage2> createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<HomePage2> {
  late Future<List<Transaction>> importedTransactionsList;
  late Future<int> transactionId;

  void loadList() async {
    try {
      importedTransactionsList = readListFromCsv();
      setState(() {
        //transactionsList.setList(importedTransactionsList);
        //transactionId = getLastID(importedTransactionsList);
      });
    } catch (ex) {
      print(ex);
    }
  }

  @override
  initState() {
    super.initState();
    //transactionId = getLastID();
    loadList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Transaction>>(
          future: importedTransactionsList,
          //initialData: transactionsList,
          builder: (BuildContext context,
              AsyncSnapshot<List<Transaction>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData && snapshot.data != null) {
              //transactionsList.setList(snapshot.data!);
              children = <Widget>[
                //HomePageList(transactionsList: snapshot.data!)
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
        //This is a classic I have a hammer so everything is a nail. This should not have been in a future builder and should be fixed (low priority though).
        future: transactionId,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          FloatingActionButton fab;
          if (snapshot.hasData && snapshot.data != null) {
            fab = FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ),
                ).then((data) {
                  loadList();
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
*/