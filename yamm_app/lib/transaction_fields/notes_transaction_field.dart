import 'package:yamm_app/transaction_fields/transaction_field.dart';

class NotesField extends TransactionField {
  @override
  int position = 8;
  @override
  Type type = String;
  @override
  String title = "notes";
  @override
  dynamic value = "";
  @override
  String strValue = "";
  NotesField() : super();

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
