import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/category_enum.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/currency_enum.dart';
import 'package:yamm_app/user_preferences.dart';
import 'package:yamm_app/functions/preferences.dart';

class TransactionControllers {
  var amountCont = TextEditingController();
  var titleCont = TextEditingController();
  String dateVal = "";
  var dateCont = TextEditingController();
  var serviceProviderCont = TextEditingController();
  var repeatOptionCont = TextEditingController();
  var endDateCont = TextEditingController();
  // var lableCont = SingleValueDropDownController();
  List<String> labels = List.empty(growable: true);
  List<String> paymentMethods = List.empty(growable: true);
  Currency currencyValue = defaultCurrency;
  TransactionCategory categoryValue = defaultCategory;
  List<bool> incomeOutcome = [false, true];

  void initControllers() {
    amountCont.text = "";
    titleCont.text = "";
    //isOutcomeCont.text = "";
    dateCont.text = DateFormat(presentDateFormat).format(DateTime.now());
    dateVal = DateFormat(transactionDateFormat).format(DateTime.now());
    serviceProviderCont.text = "";
    repeatOptionCont.text = "";
    endDateCont.text = "";
    labels = <String>[];
  }

  bool fieldsVarified() {
    return false;
  }

  Transaction setTransaction(int id) {
    Transaction transaction = Transaction(id);
    transaction.setId(id);
    transaction.setAmount(double.parse(amountCont.text));
    transaction.setDate(dateVal);
    transaction.setCurrency(currencyValue);
    transaction.setCategory(categoryValue);
    transaction.setIsOutcome(incomeOutcome[1]);
    transaction.setServiceProvider(serviceProviderCont.text);
    transaction.setLabels(labels);

    return transaction;
  }

  updateLists() {
    updateList(labels, 'labels');
    updateList(paymentMethods, 'paymentMethods');
  }

  List<dynamic> buildTransactionListItem(Transaction transaction) {
    return transaction.convertToListItem();
  }
}
