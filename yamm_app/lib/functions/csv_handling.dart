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

genCsvFileForExport() async {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  String? downloadsDirectoryPath =
      (await DownloadsPath.downloadsDirectory())?.path;
  return File('$downloadsDirectoryPath/Transactions_$formatted.csv');
}

exportCsvToDownloads() async {
  File importFile = await getCsvFile();
  final input = importFile.openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();
  File downloadsFile = await genCsvFileForExport();
  writeListToCsv(fields, file: downloadsFile);
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

writeListToCsv(List<List<dynamic>> lst, {File? file}) async {
  file ??= await getCsvFile();
  file!.open(mode: FileMode.append);
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
}

Future<List<Transaction>> getTransactionsListFromCsv() async {
  List<List<dynamic>> CsvLst = await getListFromCsv();
  List<Transaction> transactionsList = List<Transaction>.empty(growable: true);
  for (List<dynamic> textTransaction in CsvLst) {
    transactionsList.add(buildTransactionItem(textTransaction));
  }
  return transactionsList;
}

Future<List<List<dynamic>>> getListFromCsv() async {
  File file = await getCsvFile();
  final input = file.openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  return fields;
}

buildTransactionItem(List<dynamic> textTransaction) {
  Transaction transaction = Transaction(0);
  transaction.setId(textTransaction[0]);
  transaction.setSubId(textTransaction[1]);
  transaction.setTransactionType(textTransaction[2]);
  transaction.setAmount(textTransaction[3]);
  transaction.setServiceProvider(textTransaction[4]);
  transaction.setDate(textTransaction[5]);
  transaction.setCurrency(textTransaction[6]);
  transaction.setCategory(textTransaction[7]);
  transaction.setLabels(textTransaction[8]);
  transaction.setDetails(textTransaction[9]);
  return transaction;
}
