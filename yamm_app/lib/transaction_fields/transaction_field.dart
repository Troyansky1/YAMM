abstract class TransactionField {
  abstract int position;
  abstract Type type;
  abstract String title;
  abstract dynamic value;
  abstract String strValue;
  TransactionField();

  String converToString(dynamic val);
  dynamic converFromString(String val);

  void setValue(val) {
    if (val.runtimeType == String) {
      value = converFromString(val);
      strValue = val;
      print("Set the string value of $title field to $strValue");
    } else {
      value = val;
      strValue = converToString(val);
      print("Set the value of $title field to $strValue");
    }
  }

  void setStringValue(val) {
    value = converFromString(val);
    strValue = val;
    print("Set the value of $title field to $strValue");
  }

  int getPosition() {
    return position;
  }

  String getTitle() {
    return title;
  }

  dynamic getValue() {
    return value;
  }

  String getStrValue() {
    return strValue;
  }
}
