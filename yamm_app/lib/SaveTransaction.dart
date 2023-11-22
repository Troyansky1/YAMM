import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yamm_app/Transaction.dart';

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

  @override
  initState() {
    //create an element rows of type list of list. All the above data set are stored in associate list
//Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.

    employeeData = List<List<dynamic>>.empty(growable: true);
    for (int i = 0; i < 5; i++) {
//row refer to each column of a row in csv file and rows refer to each row in a file
      List<dynamic> row = List.empty(growable: true);
      row.add("Employee Name $i");
      row.add((i % 2 == 0) ? "Male" : "Female");
      row.add(" Experience : ${i * 5}");
      employeeData.add(row);
    }

    transactionsList = List<List<dynamic>>.empty(growable: true);
    transactionsList = [
      Transaction(0, 'Generic super', 10).convertToListItem(),
      Transaction(1, 'Pharmacy', 20).convertToListItem(),
      Transaction(2, 'My clothing store', 100).convertToListItem()
    ];
  }

  List<Widget> getTextWidgets(List<dynamic> lst) {
    List<Widget> widgets = [];
    for (int i = 1; i < lst.length; i++) {
      // Does not include id
      widgets.add(Text(lst[i].toString()));
    }
    return widgets;
  }

  getCsv() async {
    print("permission granted");
    Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
    String dir = "${generalDownloadDir}/mycsv1.csv";
    File f = await File('${generalDownloadDir.path}/mycsv.csv').create();
    String transactionsCSV =
        const ListToCsvConverter().convert(transactionsList);
    String keysCSV = const ListToCsvConverter().convert(transactionsList);
    print(f.lastModified().toString());
    f.writeAsString(keysCSV);
    f.writeAsString(transactionsCSV);

    if (await Permission.storage.request().isGranted) {
      print("permission granted");
      //store file in documents folder

      Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
      //String dir = "${(await getExternalStorageDirectory())!.path}/mycsv1.csv";
      String dir = "${generalDownloadDir}/mycsv1.csv";
      File f = await File('${generalDownloadDir.path}/mycsv.csv').create();
      //String file = dir;
      //File f = File(file);

      // convert rows to String and write as csv file

      String transactionsCSV =
          const ListToCsvConverter().convert(transactionsList);
      String keysCSV = const ListToCsvConverter().convert(transactionsList);
      print(f.lastModified().toString());
      f.writeAsString(keysCSV);
      f.writeAsString(transactionsCSV);
    } else {
      print("permission not granted");
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    }
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
            ListView.builder(
                shrinkWrap: true,
                itemCount: transactionsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: getTextWidgets(transactionsList[index]),
                        //Text(transactionsList[index][0].toString()),
                        //Text(transactionsList[index][1].toString()),
                        //Text(transactionsList[index][2].toString()),
                      ),
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.green,
                height: 30,
                child: TextButton(
                  onPressed: getCsv,
                  child: const Text(
                    "Export to CSV",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
