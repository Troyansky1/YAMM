import 'package:yamm_app/category_enum.dart';
import 'package:yamm_app/currency_enum.dart';
import 'package:yamm_app/transaction_fields/transaction_fields.dart';
import 'package:yamm_app/transaction_type_enum.dart';

class Transaction {
  int minAmount = 0;
  int maxAmount = 1000000;
  final int _id;
  final IdField _idField = IdField();
  final AmountField _amountField = AmountField();

  final TransactionTypeField _transactionTypeField = TransactionTypeField();
  final ServiceProviderField _serviceProviderField = ServiceProviderField();
  final DateField _dateField = DateField();
  final CurrencyField _currencyField = CurrencyField();
  final CategoryField _categoryField = CategoryField();
  final LableField _lableField = LableField();
  String paymentMethod = "";
  String notes = "notes";
  List<TransactionField?> fieldsList = [];

  Transaction(this._id) {
    setId(_id);
    setFieldsList();
  }

  void setFieldsList() {
    fieldsList = [
      _idField,
      _amountField,
      _transactionTypeField,
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
      'transactionType': _transactionTypeField.getStrValue,
      'amount': _amountField.getStrValue(),
      'serviceProvider': _serviceProviderField.getStrValue(),
      'date': _dateField.getStrValue(),
      'currency': _currencyField.getStrValue(),
      'category': _currencyField.getStrValue(),
      'lables': _lableField.getStrValue(),
    });
  }

  void initMap() {
    transactionMap.addAll({
      'id': _idField.getStrValue(),
      'transactionType': _transactionTypeField.getStrValue(),
      'amount': _amountField.getStrValue(),
      'serviceProvider': _serviceProviderField.getStrValue(),
      'date': _dateField.getStrValue(),
      'currency': _currencyField.getStrValue(),
      'category': _categoryField.getStrValue(),
      'lables': _lableField.getStrValue(),
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

  num getAmount() {
    return _amountField.getValue();
  }

  bool setTransactionType(dynamic enteredTransactionType) {
    _transactionTypeField.setValue(enteredTransactionType);
    return true;
  }

  TransactionType getTransactionType() {
    return _transactionTypeField.getValue();
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

  bool setLabels(dynamic labels) {
    _lableField.setValue(labels);
    return true;
  }

  List<String> getLabels() {
    return _lableField.value;
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
