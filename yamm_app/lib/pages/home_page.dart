import 'package:flutter/material.dart';
import 'package:yamm_app/pages/add_Transaction.dart';
import 'package:yamm_app/pages/settings.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/widgets/home_page_main.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key, required this.title, required this.transactionsListNotifier});
  final String title;
  final TransactionsListsNotifier transactionsListNotifier;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
            icon: const Icon(Icons.more_horiz_outlined)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Y.A.M.M"),
        centerTitle: true,
      ),
      body: HomePageList(
          transactionsListsNotifier: widget.transactionsListNotifier),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddTransaction(
                    transactionsListsNotifier:
                        widget.transactionsListNotifier)),
          );
        },
        tooltip: 'Add a transaction',
        child: const Icon(Icons.add),
      ),
    );
  }
}
