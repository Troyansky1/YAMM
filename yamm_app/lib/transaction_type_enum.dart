enum TransactionType {
  income(name: "Income"),
  outcome(name: "Outcome");

  const TransactionType({required this.name});
  static TransactionType getNext(TransactionType type) {
    int numValues = TransactionType.values.length;
    int currIndex = type.index;
    return TransactionType.values[(currIndex + 1) % numValues];
  }

  final String name;
}
