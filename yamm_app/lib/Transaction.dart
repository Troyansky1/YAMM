

class Transaction{
  int amount = 0;
  String title = "";
  bool isOutcome = true; // Default is outcome and not income
  DateTime date = DateTime.now();
  String serviceProvider = "";
}