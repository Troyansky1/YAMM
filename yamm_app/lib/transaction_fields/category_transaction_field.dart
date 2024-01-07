import 'package:yamm_app/category_enum.dart';
import 'package:yamm_app/transaction_fields/transaction_field.dart';
import 'package:yamm_app/user_preferences.dart';

class CategoryField extends TransactionField {
  @override
  int position = 7;
  @override
  Type type = TransactionCategory;
  @override
  String title = "category";
  @override
  dynamic value = defaultCategory;
  @override
  String strValue = defaultCategory.name;
  CategoryField() : super();

  @override
  String converToString(dynamic val) {
    return val.name;
  }

  @override
  dynamic converFromString(String val) {
    for (TransactionCategory category in TransactionCategory.values) {
      if (category.name == val) {
        return category;
      }
    }
    return defaultCurrency;
  }
}
