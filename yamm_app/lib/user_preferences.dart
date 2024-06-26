import 'package:flutter/material.dart';
import 'package:yamm_app/enum_types/enum_types.dart';
import 'package:yamm_app/transactions_list.dart';

Currency defaultCurrency = Currency.ils;
TransactionCategory defaultCategory = TransactionCategory.others;
TransactionType defaultTransactionType = TransactionType.outcome;

DateTime defaultStartYear = DateTime(2000);
DateTime defaultEndYear = DateTime(2150);
int defaultMaxLabels = 4;
String transactionDateFormat = 'yyyy-MM-dd HH:mm:ss';
String presentDateFormat = 'dd MMM yyyy HH:mm';
int daysInMonth = 31;
int monthsPerYear = DateTime.monthsPerYear;
DateFrames defaultDateFrame = DateFrames.month;
Duration defaultExpandDuration = const Duration(microseconds: 500);
Color defaultIncomeColor = Colors.green[900] as Color;
Color defaultOutcomeColor = Colors.red[900] as Color;
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
