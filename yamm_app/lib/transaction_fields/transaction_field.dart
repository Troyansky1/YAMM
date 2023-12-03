abstract class TransactionField {
  abstract int _position;
  abstract Type _type;
  abstract String _title;
  abstract String Function<R>(R value) _typeToStringFunction;
  abstract dynamic Function(String value) _stringToTypeFunction;
  abstract dynamic _value;
  abstract String _strValue;
  TransactionField();

  String converToString(dynamic value);
  dynamic converFromString(String value);

  bool setValue(value) {
    if (value.type == _type) {
      _value = value;
      _strValue = converToString(value);
      return true;
    } else if (value.type == String) {
      _value = converFromString(value);
      _strValue = value;
      return true;
    } else {
      return false;
    }
  }

  int getPosition() {
    return _position;
  }

  String getTitle() {
    return _title;
  }

  dynamic getValue() {
    return _value;
  }

  String getStrValue() {
    return _strValue;
  }
}
