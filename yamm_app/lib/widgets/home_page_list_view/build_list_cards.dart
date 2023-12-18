import 'package:flutter/material.dart';
import 'package:yamm_app/transaction.dart';
import 'package:yamm_app/widgets/home_page_list_view/build_list_item.dart';

class TransactionsListCards extends StatefulWidget {
  final List<Transaction> transactionList;
  final int day;
  final int month;
  const TransactionsListCards(
      {super.key,
      required this.transactionList,
      required this.day,
      required this.month});

  @override
  State<TransactionsListCards> createState() => _TransactionsListCardsState();
}

class _TransactionsListCardsState extends State<TransactionsListCards> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int day = widget.day;
    int month = widget.month;
    double width = MediaQuery.of(context).size.width;
    if (widget.transactionList.isNotEmpty) {
      return CustomScrollView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                ' $day.$month',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return BuildListItems.buildListItem(
                    widget.transactionList[index], width);
              },
              childCount: widget.transactionList.length,
            ),
          ),
        ],
      );
    } else {
      return const SizedBox(height: 0);
    }
  }
}
