import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/category_enum.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/currency_enum.dart';
import 'package:yamm_app/user_preferences.dart';
import 'package:yamm_app/functions/preferences.dart';

class TransactionControllers with ChangeNotifier {
  var amountCont = TextEditingController();
  var titleCont = TextEditingController();
  String dateVal = "";
  var dateCont = TextEditingController();
  var serviceProviderCont = TextEditingController();
  var repeatOptionCont = TextEditingController();
  var endDateCont = TextEditingController();
  // var lableCont = SingleValueDropDownController();
  ValueNotifier<List<String>> labels =
      ValueNotifier<List<String>>(List<String>.empty(growable: true));
  List<String> paymentMethods = [defaultPaymentMethod];
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
  }

  bool fieldsVarified() {
    return false;
  }

  void action() {
    notifyListeners();
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
    transaction.setLabels(labels.value);

    return transaction;
  }

  updateLists() {
    updateList(labels.value, 'labels');
    updateList(paymentMethods, 'paymentMethods');
  }

  List<dynamic> buildTransactionListItem(Transaction transaction) {
    return transaction.convertToListItem();
  }
}
