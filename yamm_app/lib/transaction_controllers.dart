import 'package:flutter/material.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/currency_enum.dart';
import 'package:yamm_app/user_preferences.dart';

class TransactionControllers {
  var amountCont = TextEditingController();
  var titleCont = TextEditingController();
  var isOutcomeCont = TextEditingController();
  var dateCont = TextEditingController();
  var serviceProviderCont = TextEditingController();
  var repeatOptionCont = TextEditingController();
  var endDateCont = TextEditingController();
  Currency currencyValue = defaultCurrency;
  List<bool> incomeOutcome = [true, false];

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

  List<dynamic> buildTransactionItemFromForm(int id) {
    Transaction transaction = Transaction(id);
    transaction.setId(id);
    transaction.setAmount(double.parse(amountCont.text));
    transaction.setDate(dateCont.text);
    transaction.setCurrency(currencyValue);
    transaction.setIsOutcome(incomeOutcome);
    transaction.setServiceProvider(serviceProviderCont.text);
    return transaction.convertToListItem();
  }
}
