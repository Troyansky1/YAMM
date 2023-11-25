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
  file.open(mode: FileMode.append);
  // Added delimiters at the eof
  String ValuesCSV = const ListToCsvConverter().convert(lst) + "\r\n";

  print("Wrote list to csv: $ValuesCSV");

  await file.writeAsString(
    ValuesCSV,
    mode: FileMode.append,
  );
}

DeleteCsv() async {
  File file = await getCsvFile();
  file.open(mode: FileMode.append);
  String ValuesCSV = const ListToCsvConverter().convert([[]]);
  await file.writeAsString(
    ValuesCSV,
    mode: FileMode.write,
  );
  print(ValuesCSV);
  print("Deleted list from csv");
}

Future<List<List<dynamic>>> readListFromCsv() async {
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  print("readListFromCsv");
  File file = await getCsvFile();
  final input = file.openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(new CsvToListConverter())
      .toList();
  print("fields from csv: $fields");
  return fields;
}
