import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yamm_app/functions/dateFilterDialogs.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/widgets/year_month_day_pickers.dart';

class HomePageFilters extends StatefulWidget {
  final TransactionsListsNotifier transactionsListsNotifier;

  const HomePageFilters({super.key, required this.transactionsListsNotifier});

  @override
  State<HomePageFilters> createState() => _HomePageFiltersState();
}

class _HomePageFiltersState extends State<HomePageFilters> {
  List<String> dateFrames = ["Year", "Month", "Day"];
  late String dateFrame;
  @override
  void initState() {
    super.initState();
    dateFrame = dateFrames[2];
    widget.transactionsListsNotifier
        .addListener(() => mounted ? setState(() {}) : null);
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<DateFrames>> dateFrameOptionsEntries =
        <DropdownMenuItem<DateFrames>>[];
    for (final DateFrames dateFrame in DateFrames.values) {
      dateFrameOptionsEntries.add(
        DropdownMenuItem<DateFrames>(
          value: dateFrame,
          child: Text(dateFrame.name.toString()),
        ),
      );
    }
    return Container(
        height: 50,
        width: 200,
        child: Row(
          children: <Widget>[
            const Text("Present  "),
            DropdownButton<DateFrames>(
                items: dateFrameOptionsEntries,
                value: widget.transactionsListsNotifier.dateFrame.value,
                onChanged: (DateFrames? value) {
                  showCustomDatePickerDialog(
                      widget.transactionsListsNotifier, context, value!);
                  setState(() {
                    widget.transactionsListsNotifier.dateFrame.value = value!;
                  });
                }),
            ValueListenableBuilder(
                valueListenable: widget.transactionsListsNotifier.dateFrame,
                builder: (BuildContext context, DateFrames dateFrame,
                    Widget? child) {
                  List<Widget> rowChildren = List<Widget>.empty(growable: true);
                  //w(dateFrame);
                  return Text("data");
                })
          ],
        ));
  }
}
