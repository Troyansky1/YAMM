import 'package:yamm_app/transaction_fields/transaction_field.dart';

class LableField extends TransactionField {
  @override
  int position = 7;
  @override
  Type type = List<String>;
  @override
  String title = "lables";
  @override
  dynamic value = List<String>.empty();
  @override
  String strValue = "";
  LableField() : super();

  @override
  String converToString(dynamic val) {
    return val.join('#');
  }

  @override
  dynamic converFromString(String val) {
    return val.split('#');
  }
}
