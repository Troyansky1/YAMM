import 'package:shared_preferences/shared_preferences.dart';

void setPreferenceList(String lstName, List<String> defaultList) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> lst = (prefs.getStringList(lstName) ?? []);
  if (lst.isEmpty) {
    await prefs.setStringList(lstName, defaultList);
  }
}

Future<List<String>> getPreferencesList(String lstName) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> lst = (prefs.getStringList(lstName) ?? ['others']);
  return lst;
}

addItemToList(String item, String lstName) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> items = (prefs.getStringList(lstName) ?? []);
  if (!items.contains(item)) {
    items.add(item);
    prefs.setStringList(lstName, items);
  }
}

updateList(List<String> items, String lstName) async {
  for (String item in items) {
    addItemToList(item, lstName);
  }
}
