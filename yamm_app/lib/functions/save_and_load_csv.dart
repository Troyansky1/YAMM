import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:yamm_app/transaction.dart';

getCsvFile() async {
  final directory = await getApplicationSupportDirectory();
  final path = directory.path;
  File file = File('$path/csv.csv');
  return file;
}

genFileForExport() async {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  String? downloadsDirectoryPath =
      (await DownloadsPath.downloadsDirectory())?.path;
  return File('$downloadsDirectoryPath/Transactions_$formatted.csv');
}

exportToDownloads() async {
  File importFile = await getCsvFile();
  final input = importFile.openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();
  File downloadsFile = await genFileForExport();
  writeListToCsv(fields, downloadsFile);
}

initCsv() async {
  File file = await getCsvFile();
  file.open();
  String valuesCSV = const ListToCsvConverter().convert([[]]);

  await file.writeAsString(
    valuesCSV,
    mode: FileMode.write,
  );
}

writeListToCsv(List<List<dynamic>> lst, File file) async {
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
  File file = await getCsvFile();
  writeListToCsv(lst, file);
}

deleteCsv() async {
  File file = await getCsvFile();
  file.open(mode: FileMode.append);
  String valuesCSV = const ListToCsvConverter().convert([[]]);
  await file.writeAsString(
    valuesCSV,
    mode: FileMode.write,
  );
}

Future<List<Transaction>> readListFromCsv() async {
  File file = await getCsvFile();
  final input = file.openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  return buildTransactionItemFromCsv(fields);
}

List<Transaction> buildTransactionItemFromCsv(List<List<dynamic>> lst) {
  List<Transaction> transactionsList = List<Transaction>.empty(growable: true);
  for (List<dynamic> textTransaction in lst) {
    Transaction transaction = Transaction(0);
    transaction.setId(textTransaction[0]);
    transaction.setTransactionType(textTransaction[1]);
    transaction.setAmount(textTransaction[2]);
    transaction.setServiceProvider(textTransaction[3]);
    transaction.setDate(textTransaction[4]);
    transaction.setCurrency(textTransaction[5]);
    transaction.setCategory(textTransaction[6]);
    transaction.setLabels(textTransaction[7]);
    transaction.setNotes(textTransaction[8]);

    transactionsList.add(transaction);
  }
  return transactionsList;
}

int getLastID(List<Transaction> transactionsList) {
  int id;
  List<Transaction> lst = transactionsList;
  int len = lst.length;
  if (len > 0) {
    id = lst[len - 1].getId();
    return id;
  } else {
    return 0;
  }
}
