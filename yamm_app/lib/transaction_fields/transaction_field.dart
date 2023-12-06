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
    } else {
      value = val;
      strValue = converToString(val);
    }
  }

  void setStringValue(val) {
    value = converFromString(val);
    strValue = val;
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
