import 'package:flutter/material.dart';
import 'package:yamm_app/enum_types/category_enum.dart';
import 'package:yamm_app/filters.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/widgets/home_page_filter/filter%20_list_widgets.dart';
import 'package:expandable_sliver_list/expandable_sliver_list.dart';

class filterSideSheet extends StatefulWidget {
  final TransactionsListsNotifier transactionsListsNotifier;
  const filterSideSheet({super.key, required this.transactionsListsNotifier});

  @override
  State<filterSideSheet> createState() => _filterSideSheetState();
}

class _filterSideSheetState extends State<filterSideSheet> {
  ExpandableSliverListController<TransactionCategory>
      categoriesExpandController = ExpandableSliverListController();
  ExpandableSliverListController<String> labelsExpandController =
      ExpandableSliverListController();
  Filters filters = Filters();

  void updateController(bool value, ExpandableSliverListController controller) {
    if (value) {
      controller.expand();
    } else {
      controller.collapse();
    }
  }

  @override
  void initState() {
    filters = widget.transactionsListsNotifier.filters.value;
    widget.transactionsListsNotifier
        .addListener(() => mounted ? setState(() {}) : null);
    updateController(filters.filterCategories, categoriesExpandController);
    updateController(filters.filterLabels, labelsExpandController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void filterCategoriesSwitchCallback() {
      widget.transactionsListsNotifier.toggleFilterCategories();
      widget.transactionsListsNotifier.updateFilters(fields: true);
      setState(() {
        updateController(filters.filterCategories, categoriesExpandController);
      });
    }

    void filterLabelsSwitchCallback() {
      widget.transactionsListsNotifier.toggleFilterLabels();
      widget.transactionsListsNotifier.updateFilters(fields: true);
      setState(() {
        updateController(filters.filterLabels, labelsExpandController);
      });
    }

    return CustomScrollView(
      shrinkWrap: true,
      scrollBehavior: const ScrollBehavior(),
      slivers: [
        filterAppBar(context),
        filterSwitch(context, filterCategoriesSwitchCallback,
            filters.filterCategories, "categories",
            subtitleVar: "one category"),
        createCategoriesListView(context, widget.transactionsListsNotifier,
            setState, categoriesExpandController),
        filterSwitch(
            context, filterLabelsSwitchCallback, filters.filterLabels, "labels",
            subtitleVar: "some labels"),
        createLabelsListView(context, widget.transactionsListsNotifier,
            setState, labelsExpandController),
      ],
    );
  }
}
