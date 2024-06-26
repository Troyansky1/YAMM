import 'package:yamm_app/transaction_fields/transaction_field.dart';

class DetailsField extends TransactionField {
  @override
  int position = 9;
  @override
  Type type = String;
  @override
  String title = "details";
  @override
  dynamic value = "";
  @override
  String strValue = "";
  DetailsField() : super();

  @override
  String converToString(dynamic val) {
    if (value.runtimeType == type) {
      return value;
    } else {
      return "";
    }
  }

  @override
  dynamic converFromString(String val) {
    return value;
  }
}
