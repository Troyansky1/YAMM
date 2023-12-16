import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/functions/dateFilterDialogs.dart';
import 'package:yamm_app/transactions_list.dart';

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

  Widget showDatesRange(TransactionsListsNotifier transactionsListsNotifier) {
    Text text;
    DateFrames dateFrame = transactionsListsNotifier.dateFrame.value;
    int year = transactionsListsNotifier.year.value;
    int month = transactionsListsNotifier.month.value;
    int day = transactionsListsNotifier.day.value;
    if (dateFrame == DateFrames.year) {
      text = Text(year.toString());
    } else if (dateFrame == DateFrames.month) {
      text = Text(DateFormat('yMMM').format(DateTime(year, month)));
    } else if (dateFrame == DateFrames.day) {
      text = Text(DateFormat('yMMMd').format(DateTime(year, month, day)));
    } else {
      text = Text("error");
    }
    return text;
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
        width: 400,
        child: Row(
          children: <Widget>[
            const Text("Present  "),
            DropdownButton<DateFrames>(
                items: dateFrameOptionsEntries,
                value: widget.transactionsListsNotifier.dateFrame.value,
                onChanged: (DateFrames? value) {
                  showCustomDatePickerDialog(
                          widget.transactionsListsNotifier, context, value!)
                      .then((a) => setState(() {
                            widget.transactionsListsNotifier.dateFrame.value =
                                value;
                            widget.transactionsListsNotifier.filterListDate();
                          }));
                }),
            ValueListenableBuilder(
                valueListenable: widget.transactionsListsNotifier.dateFrame,
                builder: (BuildContext context, DateFrames dateFrame,
                    Widget? child) {
                  return showDatesRange(widget.transactionsListsNotifier);
                })
          ],
        ));
  }
}
