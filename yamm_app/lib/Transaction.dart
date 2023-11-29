import 'package:yamm_app/currency_enum.dart';
import 'package:yamm_app/user_preferences.dart';

class Transaction {
  int minAmount = 0;
  int maxAmount = 1000000;
  int id;
  double amount = 0;
  bool isOutcome = true; // Default is outcome and not income
  String date = "";
  String serviceProvider = "";
  Currency currency = defaultCurrency;
  String paymentMethod = "";
  String notes = "";
  Transaction.forDebug(this.id, this.serviceProvider, this.amount);
  Transaction(this.id);
  final Map<String, dynamic> transactionMap = {}; // Is a HashMap

  void initMap() {
    transactionMap.addAll({
      'id': id,
      'isOutcome': isOutcome,
      'amount': amount,
      'serviceProvider': serviceProvider.toString(),
      'date': date,
      'currency': currency,
    });
  }

  bool addAmount(double enteredAmount) {
    if (enteredAmount >= minAmount && enteredAmount < maxAmount) {
      amount = enteredAmount;
      return true;
    } else {
      return false;
    }
  }

  bool addIsOutcome(bool enteredIsOutcome) {
    isOutcome = enteredIsOutcome;
    return true;
  }

  bool addDate(String date) {
    //String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(enteredDate);
    date = date;
    return true;
  }

  bool addServiceProvider(String enteredServiceProvider) {
    if (enteredServiceProvider != "") {
      serviceProvider = enteredServiceProvider;
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
