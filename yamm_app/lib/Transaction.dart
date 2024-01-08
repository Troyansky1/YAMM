import 'package:yamm_app/enum_types/enum_types.dart';
import 'package:yamm_app/transaction_fields/notes_transaction_field.dart';
import 'package:yamm_app/transaction_fields/transaction_fields.dart';

class Transaction {
  int minAmount = 0;
  int maxAmount = 1000000;
  final int _id;
  final IdField _idField = IdField();
  final SubIdField _subIdField = SubIdField();
  final AmountField _amountField = AmountField();
  final TransactionTypeField _transactionTypeField = TransactionTypeField();
  final ServiceProviderField _serviceProviderField = ServiceProviderField();
  final DetailsField _detailsField = DetailsField();
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
      _serviceProviderField,
      _detailsField
    ];
  }

  Map<String, dynamic> transactionMap = {}; // Is a HashMap

  String intToString<int>(int a) {
    return a.toString();
  }

  void initMapFromList(List<String> lst) {
    transactionMap.addAll({
      'id': _idField.getStrValue(),
      'subId': _subIdField.getStrValue(),
      'transactionType': _transactionTypeField.getStrValue,
      'amount': _amountField.getStrValue(),
      'serviceProvider': _serviceProviderField.getStrValue(),
      'date': _dateField.getStrValue(),
      'currency': _currencyField.getStrValue(),
      'category': _currencyField.getStrValue(),
      'lables': _lableField.getStrValue(),
      'notes': _detailsField.getStrValue()
    });
  }

  void initMap() {
    transactionMap.addAll({
      'id': _idField.getStrValue(),
      'subId': _subIdField.getStrValue(),
      'transactionType': _transactionTypeField.getStrValue(),
      'amount': _amountField.getStrValue(),
      'serviceProvider': _serviceProviderField.getStrValue(),
      'date': _dateField.getStrValue(),
      'currency': _currencyField.getStrValue(),
      'category': _categoryField.getStrValue(),
      'lables': _lableField.getStrValue(),
      'notes': _detailsField.getStrValue()
    });
  }

  void setId(dynamic id) {
    _idField.setValue(id);
  }

  int getId() {
    return _idField.getValue();
  }

  void setSubId(dynamic subId) {
    _subIdField.setValue(subId);
  }

  int getSubId() {
    return _subIdField.getValue();
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

  bool setDetails(notes) {
    if (notes != "") {
      _detailsField.setValue(notes);
      return true;
    }
    return false;
  }

  bool isEqual({int id = 0, int subId = 0}) {
    if (id == getId() && subId == getSubId()) {
      return true;
    }
    return false;
  }

  String getDetails() {
    return _detailsField.getStrValue();
  }

  List convertToListItem() {
    initMap();
    final valuesList = transactionMap.values.toList(growable: false);
    return valuesList;
  }

  List<String> convertKeysToListItem() {
    initMap();
    final valuesList = transactionMap.keys.toList(growable: false);
    return valuesList;
  }
}
