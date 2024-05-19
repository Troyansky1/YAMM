import 'package:yamm_app/enum_types/enum_types.dart';
import 'package:yamm_app/transaction_fields/transaction_field.dart';

class RepeatField extends TransactionField {
  @override
  int position = 10;
  @override
  Type type = RepeatOptions;
  @override
  String title = "repeat";
  @override
  dynamic value = "";
  @override
  String strValue = "";
  RepeatField() : super();

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
    for (RepeatOptions repeatOption in RepeatOptions.values) {
      if (repeatOption.name == val) {
        return repeatOption;
      }
    }
    return RepeatOptions.noRepeat;
  }
}
