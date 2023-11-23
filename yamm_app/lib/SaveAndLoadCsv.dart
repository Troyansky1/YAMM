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

  print("Wrote list to csv:");

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
