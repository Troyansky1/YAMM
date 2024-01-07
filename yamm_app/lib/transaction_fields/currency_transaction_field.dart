import 'package:yamm_app/transaction_fields/transaction_field.dart';
import 'package:yamm_app/currency_enum.dart';
import 'package:yamm_app/user_preferences.dart';

class CurrencyField extends TransactionField {
  @override
  int position = 6;
  @override
  Type type = Currency;
  @override
  String title = "currency";
  @override
  dynamic value = defaultCurrency;
  @override
  String strValue = defaultCurrency.name;
  CurrencyField() : super();

  @override
  String converToString(dynamic val) {
    if (val.runtimeType == type) {
      return val.name;
    } else {
      return "";
    }
  }

  @override
  dynamic converFromString(String val) {
    for (Currency currency in Currency.values) {
      if (currency.name == val) {
        return currency;
      }
    }
    return defaultCurrency;
  }
}
