import 'package:flutter/material.dart';
import 'package:yamm_app/widgets/home_page_list_show.dart';
import 'package:yamm_app/pages/add_Transaction.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/functions/save_and_load_csv.dart';
import 'package:yamm_app/transactions_list.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("error page"),
        ),
        body: const SingleChildScrollView(
            child: Column(
          children: <Widget>[Text("There is an error, try restarting the app")],
        )));
  }
}
