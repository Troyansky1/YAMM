import 'package:yamm_app/category_enum.dart';
import 'package:yamm_app/currency_enum.dart';
import 'package:yamm_app/transaction_fields/transaction_fields.dart';

class Transaction {
  int minAmount = 0;
  int maxAmount = 1000000;
  final int _id;
  final IdField _idField = IdField();
  final AmountField _amountField = AmountField();
  final IsOutcomeField _isOutcomeField = IsOutcomeField();
  final ServiceProviderField _serviceProviderField = ServiceProviderField();
  final DateField _dateField = DateField();
  final CurrencyField _currencyField = CurrencyField();
  final CategoryField _categoryField = CategoryField();
  final LableField _lableField = LableField();
  String paymentMethod = "";
  String notes = "notes";
  List<TransactionField?> fieldsList = [];

  Transaction(this._id) {
    setFieldsList();
  }

  void setFieldsList() {
    fieldsList = [
      _idField,
      _amountField,
      _isOutcomeField,
      _dateField,
      _currencyField,
      _serviceProviderField
    ];
  }

  Map<String, dynamic> transactionMap = {}; // Is a HashMap

  String intToString<int>(int a) {
    return a.toString();
  }

  void initMapFromList(List<String> lst) {
    transactionMap.addAll({
      'id': _idField.getStrValue(),
      'isOutcome': _isOutcomeField.getStrValue,
      'amount': _amountField.getStrValue(),
      'serviceProvider': _serviceProviderField.getStrValue(),
      'date': _dateField.getStrValue(),
      'currency': _currencyField.getStrValue(),
      'category': _currencyField.getStrValue(),
      'lable': _lableField.getStrValue(),
    });
  }

  void initMap() {
    transactionMap.addAll({
      'id': _idField.getStrValue(),
      'isOutcome': _isOutcomeField.getStrValue(),
      'amount': _amountField.getStrValue(),
      'serviceProvider': _serviceProviderField.getStrValue(),
      'date': _dateField.getStrValue(),
      'currency': _currencyField.getStrValue(),
      'category': _categoryField.getStrValue(),
      'lable': _lableField.getStrValue(),
    });
  }

  void setId(dynamic id) {
    _idField.setValue(id);
  }

  bool setAmount(dynamic enteredAmount) {
    _amountField.setValue(enteredAmount);
    return true;
  }

  String getAmountString() {
    return _amountField.getStrValue();
  }

  dynamic getAmount() {
    return _amountField.getValue();
  }

  bool setIsOutcome(dynamic enteredIsOutcome) {
    _isOutcomeField.setValue(enteredIsOutcome);
    return true;
  }

  bool getIsOutcome() {
    return _isOutcomeField.getValue();
  }

  bool setDate(dynamic date) {
    _dateField.setValue(date);
    return true;
  }

  DateTime getDate() {
    return _dateField.getValue();
  }

  bool setCurrency(dynamic currency) {
    _currencyField.setValue(currency);
    return true;
  }

  Currency getCurrency() {
    return _currencyField.value;
  }

  bool setCategory(dynamic category) {
    _categoryField.setValue(category);
    return true;
  }

  TransactionCategory getCategory() {
    return _categoryField.value;
  }

  bool setServiceProvider(String serviceProvider) {
    if (serviceProvider != "") {
      _serviceProviderField.setValue(serviceProvider);
      return true;
    }
    return false;
  }

  String getServiceProvider() {
    return _serviceProviderField.getStrValue();
  }

  int getId() {
    return IdField().getValue();
  }

  List convertToListItem() {
    initMap();
    final valuesList = transactionMap.values.toList(growable: false);
    return valuesList;
  }

  List convertKeysToListItem() {
    initMap();
    final valuesList = transactionMap.keys.toList(growable: false);
    return valuesList;
  }
}
