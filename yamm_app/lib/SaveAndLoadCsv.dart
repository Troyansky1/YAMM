import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

getCsvFile() async {
  final directory = await getApplicationSupportDirectory();
  final path = directory.path;
  File file = File('$path/csv.csv');
  return file;
}

writeListToCsv(List<List<dynamic>> lst) async {
  File file = await getCsvFile();
  String keysCSV = const ListToCsvConverter().convert(lst);
  String ValuesCSV = const ListToCsvConverter().convert(lst);
  await file.writeAsString(keysCSV);
  file.writeAsString(ValuesCSV);
  print("Wrote list to csv");
}

Future<List<dynamic>> readListFromCsv() async {
  late List<List<dynamic>> ImportedTransactionsList;
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  File file = getCsvFile();
  print("CSV to List");
  final input = file.openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(new CsvToListConverter())
      .toList();
  ImportedTransactionsList = fields;
  print("Read list from csv");
  return ImportedTransactionsList;
}
