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

  List convertToListItem() {
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(date);
    List<dynamic> lst = [
      {
        'id': id,
        'amount': amount,
        'isOutcome': isOutcome,
        'date': date,
        'serviceProvider': serviceProvider.toString(),
      }
    ];

    return lst;
  }
}
