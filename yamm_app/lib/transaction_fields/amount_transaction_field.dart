import 'package:yamm_app/transaction_fields/transaction_field.dart';

class amountField extends TransactionField {
  int _position = 1;
  Type _type = int;
  String _title = "amount";
  late dynamic _value;
  late String _strValue;
  amountField() : super();

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
