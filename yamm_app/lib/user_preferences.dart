import 'package:yamm_app/currency_enum.dart';
import 'package:yamm_app/category_enum.dart';
import 'package:yamm_app/transactions_list.dart';

Currency defaultCurrency = Currency.ils;
TransactionCategory defaultCategory = TransactionCategory.others;

DateTime defaultStartYear = DateTime(2000);
DateTime defaultEndYear = DateTime(2150);
int defaultMaxLabels = 6;
String transactionDateFormat = 'yyyy-MM-dd HH:mm:ss';
String presentDateFormat = 'dd MMM yyyy HH:mm';
DateFrames defaultDateFrame = DateFrames.month;
Duration defaultExpandDuration = const Duration(microseconds: 500);
List<String> defaultLabelsList = [
  'Car',
  'Food',
  'Drinks',
  'Medicine',
  'Health',
  'Beauty',
  'Clothes',
  'Shoes',
  'Parties',
  'Beauty',
  'Transportation',
  'Gas',
  'Furnitures',
  'House',
  'Sport',
  'Music',
  'Hobbies',
  'Alcohol'
];

List<String> defaultPaymentMethods = [
  'Credit card',
  'Cash',
  'Bank transfer',
  'Google Pay',
  'Apple Pay',
  'Paybox',
  'Bit',
  'Gift card'
];
String defaultPaymentMethod = defaultPaymentMethods[0];
