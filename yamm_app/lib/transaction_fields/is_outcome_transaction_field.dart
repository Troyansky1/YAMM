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
    if (val) {
      return "true";
    } else {
      return "false";
    }
  }

  @override
  dynamic converFromString(String val) {
    bool outcome = val == "true" ? true : false;

    return outcome;
  }
}
