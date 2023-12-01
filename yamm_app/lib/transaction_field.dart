class TransactionField {
  final int _position;
  final Type _type;
  final String _title;
  final String Function<_>(_ value) _typeToStringFunction;
  final _ Function<_>(String value) _stringToTypeFunction;
  var _value = 0;
  String _strValue = "";
  TransactionField(this._position, this._title, this._type,
      this._typeToStringFunction, this._stringToTypeFunction);

  bool setValue(value) {
    if (value.type == _type) {
      _value = value;
      _strValue = _typeToStringFunction(value);
      return true;
    } else if (value.type == String) {
      _value = _stringToTypeFunction(value);
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

  getValue() {
    return _value;
  }

  String getStrValue() {
    return _strValue;
  }
}
