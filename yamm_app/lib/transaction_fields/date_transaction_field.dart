import 'package:intl/intl.dart';
import 'package:yamm_app/transaction_fields/transaction_field.dart';

class DateField extends TransactionField {
  @override
  int position = 3;
  @override
  Type type = DateTime;
  @override
  String title = "date";
  @override
  dynamic value = DateTime.now();
  @override
  String strValue = "";
  DateField() : super();

  @override
  String converToString(dynamic val) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(val);
    return formattedDate;
  }

  @override
  dynamic converFromString(String val) {
    String str = val;
    DateTime time = DateTime.parse(val);
    return DateTime.parse(val);
  }
}
