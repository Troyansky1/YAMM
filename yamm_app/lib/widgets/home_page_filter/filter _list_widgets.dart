import 'package:flutter/material.dart';
import 'package:yamm_app/enum_types/category_enum.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:expandable_sliver_list/expandable_sliver_list.dart';

Widget createCategoriesListView(
    BuildContext context,
    TransactionsListsNotifier transactionsListsNotifier,
    StateSetter setState,
    ExpandableSliverListController<TransactionCategory> controller) {
  Map<TransactionCategory, bool> categoryFilters =
      transactionsListsNotifier.filters.value.categoryFilters;

  return ExpandableSliverList<TransactionCategory>(
      initialItems: TransactionCategory.values.toSet(),
      controller: controller,
      duration: const Duration(milliseconds: 1),
      expandOnInitialInsertion:
          transactionsListsNotifier.filters.value.filterCategories,
      builder: (BuildContext context, transactionCategory, int index) {
        TransactionCategory category = TransactionCategory.values[index];
        return Container(
          alignment: Alignment.center,
          child: CheckboxListTile(
            value: categoryFilters[category]!,
            title: Text(category.name,
                style: Theme.of(context).textTheme.bodyMedium),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool? value) {
              setState(() {
                transactionsListsNotifier.toggleCategoryFilterVal(category);
                transactionsListsNotifier.updateFilters(fields: true);
              });
            },
          ),
        );
      });
}

Widget createLabelsListView(
    BuildContext context,
    TransactionsListsNotifier transactionsListsNotifier,
    StateSetter setState,
    ExpandableSliverListController<String> controller) {
  Map<String, bool> labelsFilters =
      transactionsListsNotifier.filters.value.labelsFilters;

  return ExpandableSliverList<String>(
      initialItems: labelsFilters.keys.toSet(),
      controller: controller,
      duration: const Duration(milliseconds: 1),
      expandOnInitialInsertion:
          transactionsListsNotifier.filters.value.filterLabels,
      builder: (BuildContext context, label, int index) {
        //String label = labelsFilters.keys.toList()[index];
        return Container(
          alignment: Alignment.center,
          child: CheckboxListTile(
            value: labelsFilters[label]!,
            title: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool? value) {
              setState(() {
                transactionsListsNotifier.toggleLabelFilterVal(label);
                transactionsListsNotifier.updateFilters(fields: true);
              });
            },
          ),
        );
      });
}

Widget filterAppBar(BuildContext context) {
  return SliverAppBar(
    expandedHeight: 30.0,
    flexibleSpace: FlexibleSpaceBar(
      titlePadding: EdgeInsets.fromLTRB(45, 5, 0, 0),
      title:
          Text('Filter options', style: Theme.of(context).textTheme.titleLarge),
    ),
  );
}

Widget filterSwitch(
    BuildContext context, VoidCallback onChanged, bool value, String titleVar,
    {String subtitleVar = ""}) {
  return SliverToBoxAdapter(
    child: Container(
      alignment: Alignment.topLeft,
      height: MediaQuery.of(context).size.height * 0.08,
      child: SwitchListTile(
        value: value,
        title: Text(
          "Filter by $titleVar?",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: subtitleVar == ""
            ? null
            : Text("View only $subtitleVar",
                softWrap: true, style: Theme.of(context).textTheme.bodySmall),
        onChanged: (bool? value) {
          onChanged();
        },
      ),
    ),
  );
}
