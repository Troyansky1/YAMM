import 'package:yamm_app/transaction_fields/transaction_field.dart';

class idField extends TransactionField {
  int _position = 0;
  Type _type = int;
  String _title = "id";
  late dynamic _value;
  late String _strValue;
  idField() : super();

  @override
  String converToString(dynamic value) {
    if (value.runtimeType == _type) {
      return value.toString();
    } else {
      return "";
    }
  }

  @override
  dynamic converFromString(String value) {
    return int.parse(value);
  }
}
