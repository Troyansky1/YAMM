import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/functions/filter_transactions.dart';
import 'package:yamm_app/transaction_type_enum.dart';

int calcIncomesOutcomes(lst, TransactionType transactionType) {
  num totalAmounts = 0;
  List<Transaction> filteredList = filterIncomeOutcome(lst, transactionType);
  for (Transaction t in filteredList) {
    totalAmounts += t.getAmount();
  }
  return totalAmounts.toInt();
}

int calcBalance(lst) {
  int income = calcIncomesOutcomes(lst, TransactionType.income);
  int outcome = calcIncomesOutcomes(lst, TransactionType.outcome);
  int balance = income - outcome;
  return balance;
}
