import 'package:yamm_app/enum_types/transaction_type_enum.dart';

enum TransactionCategory {
  others(
      name: "Others",
      transactionTypes: [TransactionType.outcome, TransactionType.income]),
  salary(name: "Salary", transactionTypes: [TransactionType.income]),
  refund(name: "Refund", transactionTypes: [TransactionType.income]),
  shopping(name: "Shopping", transactionTypes: [TransactionType.outcome]),
  services(name: "Services", transactionTypes: [TransactionType.outcome]),
  leisure(name: "Leisure", transactionTypes: [TransactionType.outcome]),
  bills(name: "Bills", transactionTypes: [TransactionType.outcome]),
  gift(
      name: "Gifts",
      transactionTypes: [TransactionType.outcome, TransactionType.income]);

  const TransactionCategory(
      {required this.name, required this.transactionTypes});

  final String name;
  final List<TransactionType> transactionTypes;
}
