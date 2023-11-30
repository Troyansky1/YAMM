import 'package:yamm_app/currency_enum.dart';
import 'package:yamm_app/transaction_fields_enum.dart';
import 'package:yamm_app/user_preferences.dart';

class Transaction {
  int minAmount = 0;
  int maxAmount = 1000000;
  int _id;
  double _amount = 0;
  bool _isOutcome = true; // Default is outcome and not income
  String _date = "";
  String _serviceProvider = "";
  Currency _currency = defaultCurrency;
  String paymentMethod = "";
  String notes = "";
  Transaction.forDebug(this._id, this._serviceProvider, this._amount);
  Transaction(this._id);
  Map<String, dynamic> transactionMap = {}; // Is a HashMap
  late ({
    String id,
    String isOutcome,
    String amount,
    String serviceProvider,
    String date,
    String currency,
  }) transactionRecord;

  void initMapFromList(List<dynamic> lst) {

    for (var val in lst){
      
      transactionMap.update(TransactionEnum., (value) => null)
    }
    transactionMap.addAll({
      'id': lst[0],
      'isOutcome': _isOutcome,
      'amount': _amount,
      'serviceProvider': _serviceProvider.toString(),
      'date': _date,
      'currency': _currency,
    });
  }

  void initRecordFromFields(List<dynamic> lst) {}
  void initFieldsFromList(List<dynamic> lst) {}

  void initMap() {
    transactionMap.addAll({
      'id': _id,
      'isOutcome': _isOutcome,
      'amount': _amount,
      'serviceProvider': _serviceProvider.toString(),
      'date': _date,
      'currency': _currency,
    });
  }

  bool addAmount(double enteredAmount) {
    if (enteredAmount >= minAmount && enteredAmount < maxAmount) {
      _amount = enteredAmount;
      return true;
    } else {
      return false;
    }
  }

  bool addIsOutcome(List<bool> enteredIsOutcome) {
    _isOutcome = enteredIsOutcome[1];
    return true;
  }

  bool addDate(String date) {
    //String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(enteredDate);
    _date = date;
    return true;
  }

  bool addCurrency(Currency currency) {
    _currency = currency;
    return true;
  }

  bool addServiceProvider(String serviceProvider) {
    if (serviceProvider != "") {
      _serviceProvider = serviceProvider;
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
