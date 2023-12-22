import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yamm_app/pages/home_page.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/functions/save_and_load_csv.dart';
import 'package:yamm_app/transactions_list.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({super.key, required this.title});
  final String title;

  @override
  State<LoadPage> createState() => _MyLoadPageState();
}

class _MyLoadPageState extends State<LoadPage> {
  List<Transaction> initTransactionsList =
      List<Transaction>.empty(growable: true);
  late Future<List<Transaction>> importedTransactionsList;
  final TransactionsListsNotifier lists = TransactionsListsNotifier();

  bool isLoading = true;

  @override
  void initState() {
    _checkIfFirstOpen();
    super.initState();
  }

  Future<void> loadList() async {
    try {
      importedTransactionsList = readListFromCsv();
      setState(() {
        importedTransactionsList = importedTransactionsList;
      });
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> _checkIfFirstOpen() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasOpened = (prefs.getBool('hasOpened') ?? false);

    if (!hasOpened) {
      await initCsv();
      lists.setList(await readListFromCsv());
      lists.updateFilters();
      setState(() {
        isLoading = false;
      });
      prefs.setBool('hasOpened', true);
    } else {
      lists.setList(await readListFromCsv());
      lists.updateFilters();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : HomePage(title: "Home page", transactionsListNotifier: lists);
  }
}
