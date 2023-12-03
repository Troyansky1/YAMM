import 'package:intl/intl.dart';
import 'package:yamm_app/transaction_fields/transaction_field.dart';

class serviceProviderField extends TransactionField {
  int _position = 4;
  Type _type = String;
  String _title = "service provider";
  late dynamic _value;
  late String _strValue;
  serviceProviderField() : super();

  @override
  String converToString(dynamic value) {
    if (value.runtimeType == _type) {
      return value;
    } else {
      return "";
    }
  }

  @override
  dynamic converFromString(String value) {
    return value;
  }
}
