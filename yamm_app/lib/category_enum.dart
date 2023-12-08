enum TransactionCategory {
  others(name: "Others", income: true, outcome: true),
  bills(name: "Bills", income: false, outcome: true),
  leisure(name: "Leisure", income: false, outcome: true),
  shopping(name: "Shopping", income: false, outcome: true),
  services(name: "Services", income: false, outcome: true);

  const TransactionCategory(
      {required this.name, required this.income, required this.outcome});

  final String name;
  final bool income;
  final bool outcome;
}
