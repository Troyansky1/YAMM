import 'package:yamm_app/transaction_fields/transaction_field.dart';

class IdField extends TransactionField {
  @override
  int position = 0;
  @override
  Type type = int;
  @override
  String title = "id";
  @override
  dynamic value = 0;
  @override
  String strValue = "0";
  IdField() : super();

  @override
  String converToString(dynamic val) {
    if (val.runtimeType == type) {
      return val.toString();
    } else {
      return "";
    }
  }

  @override
  dynamic converFromString(String val) {
    return int.parse(val);
  }
}
