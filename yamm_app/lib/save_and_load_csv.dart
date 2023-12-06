import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:yamm_app/transaction.dart';

getCsvFile() async {
  final directory = await getApplicationSupportDirectory();
  final path = directory.path;
  File file = File('$path/csv.csv');
  return file;
}

writeListToCsv(List<List<dynamic>> lst) async {
  File file = await getCsvFile();
  file.open(mode: FileMode.append);
  // Added delimiters at the eof
  String valuesCSV = "${const ListToCsvConverter().convert(lst)}\r\n";

  await file.writeAsString(
    valuesCSV,
    mode: FileMode.append,
  );
}

appendItemToCsv(List<dynamic> item) async {
  List<List<dynamic>> lst = [];
  lst.add(item);
  writeListToCsv(lst);
}

deleteCsv() async {
  File file = await getCsvFile();
  file.open(mode: FileMode.append);
  String valuesCSV = const ListToCsvConverter().convert([[]]);
  await file.writeAsString(
    valuesCSV,
    mode: FileMode.write,
  );
  //print(ValuesCSV);
  //print("Deleted list from csv");
}

Future<List<Transaction>> readListFromCsv() async {
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //print("readListFromCsv");
  File file = await getCsvFile();
  final input = file.openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();
  print("fields from csv: $fields");

  return buildTransactionItemFromCsv(fields);
}

List<Transaction> buildTransactionItemFromCsv(List<List<dynamic>> lst) {
  List<Transaction> transactionsList = List<Transaction>.empty(growable: true);
  for (List<dynamic> textTransaction in lst) {
    Transaction transaction = Transaction(0);
    transaction.setId(textTransaction[0]);
    transaction.setIsOutcome(textTransaction[1]);
    transaction.setAmount(textTransaction[2]);
    transaction.setServiceProvider(textTransaction[3]);
    transaction.setDate(textTransaction[4]);
    transaction.setCurrency(textTransaction[5]);

    transactionsList.add(transaction);
  }
  return transactionsList;
}

Future<int> getLastID(Future<List<Transaction>> transactionsList) async {
  int id;
  List<Transaction> lst = await transactionsList;
  int len = lst.length;
  id = lst[len - 1].getId();

  return id;
}
