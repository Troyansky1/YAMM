import 'package:shared_preferences/shared_preferences.dart';

void setLabels() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('labels', ['Shopping', 'Car', 'Food', 'Health']);
}

Future<List<String>> getLabels() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> labels = (prefs.getStringList('labels') ?? ["others"]);
  return labels;
}

addLabel(String label) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> labels = (prefs.getStringList('labels') ?? []);
  if (!labels.contains(label)) {
    labels.add(label);
    prefs.setStringList('labels', labels);
  }
}

updateLabels(List<String> labels) async {
  for (String label in labels) {
    addLabel(label);
  }
}
