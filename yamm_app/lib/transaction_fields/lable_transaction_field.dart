import 'package:yamm_app/transaction_fields/transaction_field.dart';

class LableField extends TransactionField {
  @override
  int position = 7;
  @override
  Type type = String;
  @override
  String title = "lable";
  @override
  dynamic value = "";
  @override
  String strValue = "";
  LableField() : super();

  @override
  String converToString(dynamic val) {
    return val;
  }

  @override
  dynamic converFromString(String val) {
    return val;
  }
}
