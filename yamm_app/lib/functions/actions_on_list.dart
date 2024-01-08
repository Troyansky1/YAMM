import "package:yamm_app/functions/csv_handling.dart";
import "package:yamm_app/transaction.dart";

exportList() async {
  exportCsvToDownloads();
}

initList() async {
  initCsv();
}

Future<List<Transaction>> readList() async {
  return readListFromCsv();
}

deleteList() async {
  deleteCsv();
}

appendToList(List<dynamic> item) async {
  appendItemToCsv(item);
}

int getLastID(List<Transaction> transactionsList) {
  int id;
  List<Transaction> lst = transactionsList;
  int len = lst.length;
  if (len > 0) {
    Transaction lastTransaction = lst[len - 1];
    id = lastTransaction.getId() + 1;
    return id;
  } else {
    return 0;
  }
}
