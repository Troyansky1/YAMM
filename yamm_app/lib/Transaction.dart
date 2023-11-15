class Transaction {
  int amount = 0;
  String notes = "";
  bool isOutcome = true; // Default is outcome and not income
  DateTime date = DateTime.now();
  String serviceProvider = "";
  String currency = "";
  String paymentMethod = "";
}
