import 'package:intl/intl.dart';
import 'package:yamm_app/transaction_fields/transaction_field.dart';

class dateField extends TransactionField {
  int _position = 3;
  Type _type = DateTime;
  String _title = "date";
  late dynamic _value;
  late String _strValue;
  dateField() : super();
  @override
  String converToString(dynamic value) {
    if (value.runtimeType == _type) {
      String formattedDate = DateFormat('dd/MM/yy – kk:mm').format(value);
      return formattedDate;
    } else {
      return "";
    }
  }

  @override
  dynamic converFromString(String value) {
    return DateTime.parse(value);
  }
}
