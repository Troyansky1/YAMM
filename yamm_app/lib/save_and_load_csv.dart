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
  String ValuesCSV = const ListToCsvConverter().convert(lst) + "\r\n";

  print("Wrote list to csv: $ValuesCSV");

  await file.writeAsString(
    ValuesCSV,
    mode: FileMode.append,
  );
}

AppendItemToCsv(List<dynamic> item) async {
  List<List<dynamic>> lst = [];
  lst.add(item);
  writeListToCsv(lst);
}

DeleteCsv() async {
  File file = await getCsvFile();
  file.open(mode: FileMode.append);
  String ValuesCSV = const ListToCsvConverter().convert([[]]);
  await file.writeAsString(
    ValuesCSV,
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
  int ID;
  int len = importedList.length;
  if (len > 0) {
    int lastId = importedList[len - 1][0];
    ID = lastId + 1;
    print("The last id is $lastId and the new is $ID");
  } else {
    ID = 0;
  }

  return ID;
}
