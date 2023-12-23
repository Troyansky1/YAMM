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
