
import 'package:intl/intl.dart';

class Transaction {
  int id;
  int amount = 0;
  bool isOutcome = true; // Default is outcome and not income
  DateTime date = DateTime.now();
  String serviceProvider = "";
  String currency = "";
  String paymentMethod = "";
  String notes = "";
  Transaction(this.id, this.serviceProvider, this.amount);
  final Map<String, dynamic> transactionMap = {}; // Is a HashMap

  void initMap() {
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(date);
    transactionMap.addAll({
      'id': id,
      'serviceProvider': serviceProvider.toString(),
      'amount': amount,
      'isOutcome': isOutcome,
      'date': formattedDate,
    });
  }

  static List<String> genListOfKeys() {
    List<String> lst = [
      'id',
      'serviceProvider',
      'amount',
      'isOutcome',
      'date',
    ];
    return lst;
  }

  List convertToListItem() {
    initMap();
    final valuesList = transactionMap.values.toList(growable: false);
    return valuesList;
  }

  List convertKeysToListItem() {
    initMap();
    final valuesList = transactionMap.values.toList(growable: false);
    return valuesList;
  }
}
