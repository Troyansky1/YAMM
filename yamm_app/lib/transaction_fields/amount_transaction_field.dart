import 'package:yamm_app/currency_enum.dart';
import 'package:yamm_app/transaction_fields/transaction_field.dart';

class AmountField extends TransactionField {
  @override
  int position = 2;
  @override
  Type type = num;
  @override
  String title = "amount";
  @override
  dynamic value = 0;
  @override
  String strValue = "0";
  AmountField() : super();

  @override
  String converToString(dynamic val) {
    return val.toString();
  }

  @override
  dynamic converFromString(String val) {
    for (Currency curr in Currency.values) {
      if (val == curr.name) {
        return curr;
      }
    }
    return "Not a currency";
  }
}
