import 'package:yamm_app/transaction_fields/transaction_field.dart';
import 'package:yamm_app/transaction_type_enum.dart';
import 'package:yamm_app/user_preferences.dart';

class TransactionTypeField extends TransactionField {
  @override
  int position = 3;
  @override
  Type type = TransactionType;
  @override
  String title = "transactionType";
  @override
  dynamic value = true;
  @override
  String strValue = defaultTransactionType.name;
  TransactionTypeField() : super();

  @override
  String converToString(dynamic val) {
    return val.name;
  }

  @override
  dynamic converFromString(String val) {
    for (TransactionType type in TransactionType.values) {
      if (type.name == val) {
        return type;
      }
    }

    return defaultTransactionType;
  }
}
