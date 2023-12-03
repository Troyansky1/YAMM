import 'package:yamm_app/transaction_fields/transaction_field.dart';

class IsOutcomeField extends TransactionField {
  @override
  int position = 2;
  @override
  Type type = bool;
  @override
  String title = "isOutcome";
  @override
  dynamic value = true;
  @override
  String strValue = "true";
  IsOutcomeField() : super();

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
    return val == "true" ? true : false;
  }
}
