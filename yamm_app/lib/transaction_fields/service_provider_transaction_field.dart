import 'package:yamm_app/transaction_fields/transaction_field.dart';

class ServiceProviderField extends TransactionField {
  @override
  int position = 5;
  @override
  Type type = String;
  @override
  String title = "service provider";
  @override
  dynamic value = "";
  @override
  String strValue = "";
  ServiceProviderField() : super();

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
