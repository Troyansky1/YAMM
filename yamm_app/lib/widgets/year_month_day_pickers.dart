import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/transactions_list.dart';

class YearMonthPicker extends StatefulWidget {
  YearMonthPicker(
      {required this.transactionsListsNotifier,
      required this.initialYear,
      required this.startYear,
      required this.endYear,
      required this.pickMonth,
      Key? key})
      : super(key: key);
  final TransactionsListsNotifier transactionsListsNotifier;
  late final int initialYear;
  late final int startYear;
  late final int endYear;
  late final bool pickMonth;
  @override
  State<YearMonthPicker> createState() => _YearMonthPickerState();
}

class _YearMonthPickerState extends State<YearMonthPicker> {
  final List<int> _monthList = [
    DateTime.january,
    DateTime.february,
    DateTime.march,
    DateTime.april,
    DateTime.may,
    DateTime.june,
    DateTime.july,
    DateTime.august,
    DateTime.september,
    DateTime.october,
    DateTime.november,
    DateTime.december,
  ];

  late int selectedMonth;
  late int selectedYear;
  late String selectedMonthStr;
  late String selectedYearStr;

  final List<DropdownMenuItem<int>> monthsOptions =
      List<DropdownMenuItem<int>>.empty(growable: true);
  final List<DropdownMenuItem<int>> yearOptions =
      List<DropdownMenuItem<int>>.empty(growable: true);

  @override
  void initState() {
    for (final int month in _monthList) {
      monthsOptions.add(
        DropdownMenuItem<int>(
          value: month,
          child: Text(DateFormat('MMMM')
              .format(DateTime(0, month))), //MMM will abbreviate
        ),
      );
    }

    for (int year = widget.startYear; year <= widget.endYear; year++) {
      yearOptions.add(
        DropdownMenuItem<int>(
          value: year,
          child: Text(year.toString()),
        ),
      );
    }
    selectedMonth = widget.transactionsListsNotifier.filters.value.monthFilter;
    selectedYear = widget.transactionsListsNotifier.filters.value.yearFilter;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedMonthStr =
            DateFormat('MMMM').format(DateTime(0, selectedMonth));
        selectedYearStr = selectedYear.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pick a date",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              )),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DropdownButton<int>(
                underline: Container(),
                items: yearOptions,
                value: selectedYear,
                onChanged: (val) {
                  setState(() {
                    selectedYear = val!;
                    selectedYearStr =
                        DateFormat('YYYY').format(DateTime(0, val));
                  });
                },
              ),
              if (widget.pickMonth)
                Expanded(
                  child: DropdownButton<int>(
                    underline: Container(),
                    items: monthsOptions,
                    value: selectedMonth,
                    onChanged: (val) {
                      setState(() {
                        selectedMonth = val!;
                        selectedMonthStr =
                            DateFormat('MMMM').format(DateTime(0, val));
                      });
                    },
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    widget.transactionsListsNotifier.filters.value.yearFilter =
                        selectedYear;
                    widget.transactionsListsNotifier.filters.value.monthFilter =
                        selectedMonth;
                    Navigator.pop(
                      context,
                    );
                  },
                  child: const Text(
                    "OK",
                  ))
            ],
          )
        ],
      ),
    );
  }
}
