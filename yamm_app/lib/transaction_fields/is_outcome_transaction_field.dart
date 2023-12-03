import 'package:yamm_app/transaction_fields/transaction_field.dart';

class isOutcomeField extends TransactionField {
  int _position = 2;
  Type _type = bool;
  String _title = "isOutcome";
  late dynamic _value;
  late String _strValue;
  isOutcomeField() : super();

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
    return value == "true" ? true : false;
  }
}
