import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/functions/filter_transactions.dart';

int calcIncomesOutcomes(lst, bool outcome) {
  num totalAmounts = 0;
  List<Transaction> filteredList = filterIncomeOutcome(lst, outcome);
  for (Transaction t in filteredList) {
    totalAmounts += t.getAmount();
  }
  return totalAmounts.toInt();
}

int calcBalance(lst) {
  int income = calcIncomesOutcomes(lst, false);
  int outcome = calcIncomesOutcomes(lst, true);
  int balance = income - outcome;
  return balance;
}
