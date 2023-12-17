import 'package:flutter/material.dart';
import 'package:yamm_app/category_enum.dart';
import 'package:yamm_app/transactions_list.dart';

class filterSideSheet extends StatefulWidget {
  final TransactionsListsNotifier transactionsListsNotifier;
  const filterSideSheet({super.key, required this.transactionsListsNotifier});

  @override
  State<filterSideSheet> createState() => _filterSideSheetState();
}

class _filterSideSheetState extends State<filterSideSheet> {
  @override
  void initState() {
    widget.transactionsListsNotifier
        .addListener(() => mounted ? setState(() {}) : null);
    super.initState();
  }

  Widget createCategoriesListView(BuildContext context,
      TransactionsListsNotifier transactionsListsNotifier) {
    Map<TransactionCategory, bool> categoryFilters =
        transactionsListsNotifier.filters.value.categoryFilters;

    return SliverList.builder(
        itemCount: categoryFilters.length,
        itemBuilder: (BuildContext context, int index) {
          TransactionCategory category = TransactionCategory.values[index];
          return Container(
            alignment: Alignment.center,
            color: Colors.lightBlue,
            child: SwitchListTile(
              value: categoryFilters[category]!,
              title: Text(category.name),
              onChanged: (bool? value) {
                setState(() {
                  transactionsListsNotifier.toggleCategoryFilterVal(category);
                });
              },
            ),
          );
        });
  }

  Widget createLabelsListView(BuildContext context,
      TransactionsListsNotifier transactionsListsNotifier) {
    Map<String, bool> labelsFilters =
        transactionsListsNotifier.filters.value.labelsFilters;

    return SliverList.builder(
        itemCount: labelsFilters.length,
        itemBuilder: (BuildContext context, int index) {
          String label = labelsFilters.keys.toList()[index];
          return Container(
            alignment: Alignment.center,
            color: Colors.lightBlue,
            child: SwitchListTile(
              value: labelsFilters[label]!,
              title: Text(label),
              onChanged: (bool? value) {
                setState(() {
                  transactionsListsNotifier.toggleLabelFilterVal(label);
                });
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      scrollBehavior: ScrollBehavior(),
      slivers: <Widget>[
        const SliverAppBar(
          pinned: true,
          floating: false,
          snap: false,
          forceElevated: true,
          expandedHeight: 50.0,
          flexibleSpace: FlexibleSpaceBar(
            title:
                Text('Filter options', style: TextStyle(color: Colors.black)),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.lightBlueAccent,
            alignment: Alignment.topLeft,
            height: 30,
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: Text("Categories"),
            ),
          ),
        ),
        createCategoriesListView(context, widget.transactionsListsNotifier),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.lightBlueAccent,
            alignment: Alignment.topLeft,
            height: 30,
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: Text("Labels"),
            ),
          ),
        ),
        createLabelsListView(context, widget.transactionsListsNotifier),
      ],
    );
  }
}
