import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/enum_types/category_enum.dart';
import 'package:yamm_app/functions/csv_handling.dart';
import 'package:yamm_app/enum_types/repeat_enum.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/enum_types/currency_enum.dart';
import 'package:yamm_app/enum_types/transaction_type_enum.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/user_preferences.dart';
import 'package:yamm_app/functions/preferences.dart';

class TransactionControllers with ChangeNotifier {
  var id = 0;
  var amountCont = TextEditingController();
  var titleCont = TextEditingController();
  String dateVal = "";
  var dateCont = TextEditingController();
  var serviceProviderCont = TextEditingController();
  var notesCont = TextEditingController();
  var repeatOptionCont = TextEditingController();
  var endDateCont = TextEditingController();
  // var lableCont = SingleValueDropDownController();
  ValueNotifier<List<String>> labels =
      ValueNotifier<List<String>>(List<String>.empty(growable: true));
  ValueNotifier<List<String>> paymentMethods =
      ValueNotifier<List<String>>([defaultPaymentMethod]);

  Currency currencyValue = defaultCurrency;
  TransactionCategory categoryValue = defaultCategory;
  ValueNotifier<TransactionType> transactionType =
      ValueNotifier<TransactionType>(defaultTransactionType);

  void initControllers(int id) {
    this.id = id;
    amountCont.text = "";
    titleCont.text = "";
    //isOutcomeCont.text = "";
    dateCont.text = DateFormat(presentDateFormat).format(DateTime.now());
    dateVal = DateFormat(transactionDateFormat).format(DateTime.now());
    serviceProviderCont.text = "";
    notesCont.text = "";
    repeatOptionCont.text = "";
    endDateCont.text = "";
  }

  bool fieldsVarified() {
    return false;
  }

  void notify() {
    notifyListeners();
  }

  setId(int id) {
    this.id = id;
  }

  Transaction setTransaction(int id, int subId) {
    Transaction transaction = Transaction(id);
    transaction.setId(id);
    transaction.setSubId(subId);
    transaction.setAmount(double.parse(amountCont.text));
    transaction.setDate(dateVal);
    transaction.setCurrency(currencyValue);
    transaction.setCategory(categoryValue);
    transaction.setTransactionType(transactionType.value);
    transaction.setServiceProvider(serviceProviderCont.text);
    transaction.setLabels(labels.value);
    transaction.setDetails(notesCont.text);

    return transaction;
  }

  void updateUserPreferences(
      TransactionsListsNotifier transactionsListsNotifier) {
    updateList(labels.value, 'labels');
    updateList(paymentMethods.value, 'paymentMethods');
    transactionsListsNotifier.setLabelsMap();
  }

  List buildTransactionListItem(Transaction transaction) {
    return transaction.convertToListItem();
  }

  onSave(BuildContext context, GlobalKey<FormState> formKey,
      TransactionsListsNotifier transactionsListsNotifier) {
    if (formKey.currentState!.validate()) {
      showSnackbar(context);
      saveTransaction(transactionsListsNotifier);
      updateUserPreferences(transactionsListsNotifier);
      Navigator.pop(context);
    } else {
      showSnackbar(context, error: true);
    }
  }

  void savetransactions(TransactionsListsNotifier transactionsListsNotifier) {
    if (repeatOptionCont.text != RepeatOptions.noRepeat.name) {
    } else {
      saveTransaction(transactionsListsNotifier);
    }
  }

  void saveTransaction(TransactionsListsNotifier transactionsListsNotifier,
      {int subId = 0}) {
    Transaction transaction = setTransaction(id, subId);
    List transactionListItem;
    transactionListItem = buildTransactionListItem(transaction);

    appendItemToCsv(transactionListItem);
    transactionsListsNotifier.addTransaction(transaction);
  }

  void showSnackbar(BuildContext context, {bool error = false}) {
    if (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fix the data')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }
}
