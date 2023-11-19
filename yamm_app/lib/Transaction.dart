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
}
