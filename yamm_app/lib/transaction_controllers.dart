import 'package:flutter/material.dart';
import 'package:yamm_app/Transaction.dart';

class TransactionControllers {
  var amountCont = TextEditingController();
  var titleCont = TextEditingController();
  var isOutcomeCont = TextEditingController();
  var dateCont = TextEditingController();
  var serviceProviderCont = TextEditingController();
  var repeatOptionCont = TextEditingController();
  var endDateCont = TextEditingController();

  TransactionControllers();

  void initControllers() {
    amountCont.text = "0";
    titleCont.text = "";
    isOutcomeCont.text = "";
    dateCont.text = "";
    serviceProviderCont.text = "";
    repeatOptionCont.text = "";
    endDateCont.text = "";
  }

  bool fieldsVarified() {
    return false;
  }

  List<dynamic> buildTransactionItem(int id) {
    Transaction transaction = Transaction(id);
    transaction.addAmount(double.parse(amountCont.text));
    transaction.addDate(dateCont.text);
    return transaction.convertToListItem();
  }
}
