import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yamm_app/filters.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/widgets/home_page_list_view/build_transaction_list_item.dart';

class BuildListCardsDay extends StatefulWidget {
  final TransactionsListsNotifier transactionsListsNotifier;
  final BuildContext context;
  final List<Transaction> transactionsList;

  BuildListCardsDay(
      {required this.context,
      required this.transactionsListsNotifier,
      required this.transactionsList,
      super.key});

  @override
  State<BuildListCardsDay> createState() => _BuildListCardsDayState();
}

class _BuildListCardsDayState extends State<BuildListCardsDay> {
  late ValueListenable filtersListenable;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget createDayScrollView() {
    return CustomScrollView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        slivers: [createTransactionsSliverItem()]);
  }

  Widget createTransactionsSliverItem() {
    return SliverList.builder(
      itemCount: widget.transactionsList.length,
      itemBuilder: (BuildContext context, int index) {
        return BuildTransactionListItems.buildListItem(
            widget.transactionsList[index], context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Filters>(
        valueListenable: widget.transactionsListsNotifier.filters,
        builder: (BuildContext context, Filters filters, Widget? child) {
          return createDayScrollView();
        });
  }
}
