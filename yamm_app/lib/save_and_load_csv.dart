import 'dart:io';
import 'dart:convert';
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
  String valuesCSV = const ListToCsvConverter().convert(lst) + "\r\n";

  print("Wrote list to csv: $valuesCSV");

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

Future<List<List<dynamic>>> readListFromCsv() async {
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //print("readListFromCsv");
  File file = await getCsvFile();
  final input = file.openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(new CsvToListConverter())
      .toList();
  //print("fields from csv: $fields");
  return fields;
}

int getLastID(List<List<dynamic>> importedList) {
  int id;
  int len = importedList.length;
  if (len > 0) {
    int lastId = importedList[len - 1][0];
    id = lastId + 1;
  } else {
    id = 0;
  }

  return id;
}
