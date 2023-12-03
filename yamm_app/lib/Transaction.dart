import 'package:yamm_app/currency_enum.dart';
import 'package:yamm_app/transaction_fields/currency_transaction_field.dart';
import 'package:yamm_app/transaction_fields/transaction_fields.dart';

class Transaction {
  int minAmount = 0;
  int maxAmount = 1000000;
  int _id = 0;
  final IdField _idField = IdField();
  final AmountField _amountField = AmountField();
  final IsOutcomeField _isOutcomeField = IsOutcomeField();
  final ServiceProviderField _serviceProviderField = ServiceProviderField();
  final DateField _dateField = DateField();
  final CurrencyField _currencyField = CurrencyField();
  String paymentMethod = "";
  String notes = "";
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
    });
  }

  void initRecordFromFields(List<dynamic> lst) {}

  void initFieldsFromList(List<dynamic> lst) {}

  void initMap() {
    transactionMap.addAll({
      'id': _idField.getStrValue(),
      'isOutcome': _isOutcomeField.getStrValue,
      'amount': _amountField.getStrValue(),
      'serviceProvider': _serviceProviderField.getStrValue(),
      'date': _dateField.getStrValue(),
      'currency': _currencyField.getStrValue(),
    });
  }

  bool addAmount(double enteredAmount) {
    print("enteredAmount = $enteredAmount");
    if (enteredAmount >= minAmount && enteredAmount < maxAmount) {
      _amountField.setValue(enteredAmount);

      return true;
    } else {
      return false;
    }
  }

  bool addIsOutcome(List<bool> enteredIsOutcome) {
    _isOutcomeField.setValue(enteredIsOutcome[0]);
    return true;
  }

  bool addDate(String date) {
    _dateField.setStringValue(date);
    return true;
  }

  bool addCurrency(Currency currency) {
    _currencyField.setValue(currency);
    return true;
  }

  bool addServiceProvider(String serviceProvider) {
    if (serviceProvider != "") {
      _serviceProviderField.setValue(serviceProvider);
      return true;
    }
    return false;
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
