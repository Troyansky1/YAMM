import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yamm_app/Transaction.dart';
import 'package:yamm_app/SaveAndLoadCsv.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<List<dynamic>> employeeData;
  late List<List<dynamic>> transactionsList;
  late List<List<dynamic>> ImportedTransactionsList;

  @override
  initState() {
    ImportedTransactionsList = List<List<dynamic>>.empty(growable: true);
    transactionsList = List<List<dynamic>>.empty(growable: true);
    transactionsList = [
      Transaction(0, 'Generic super', 10).convertToListItem(),
      Transaction(1, 'Pharmacy', 20).convertToListItem(),
      //Transaction(2, 'My clothing store', 100).convertToListItem(),
      //Transaction(2, 'My clothing store2', 100).convertToListItem()
    ];
  }

  readListFromCsv() async {
    //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    File file = await getCsvFile();
    print("CSV to List");
    final input = file.openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(new CsvToListConverter())
        .toList();
    setState(() {
      ImportedTransactionsList = fields;
    });

    print("Read list from csv");
    print(ImportedTransactionsList);
  }

  List<Widget> getTextWidgets(List<dynamic> lst) {
    List<Widget> widgets = [];
    for (int i = 0; i < lst.length; i++) {
      // Includes all fields
      widgets.add(Text(lst[i].toString()));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Flutter CSV Upload"),
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
            TextButton(
              onPressed: () => readListFromCsv(),
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

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
