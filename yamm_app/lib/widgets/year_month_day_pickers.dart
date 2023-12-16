import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthPicker extends StatefulWidget {
  MonthPicker(
      {required this.initialYear,
      required this.startYear,
      required this.endYear,
      required this.currentYear,
      required this.month,
      Key? key})
      : super(key: key);
  late int initialYear;
  late int startYear;
  late int endYear;
  late int currentYear;
  late int month;
  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
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

  late int selectedMonthIndex;
  late int selectedYearIndex;
  String selectedMonth = "";
  String selectedYear = "";
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
    selectedMonthIndex = widget.month - 1;
    selectedYearIndex = widget.currentYear!;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedMonth =
            DateFormat('MMMM').format(DateTime(0, selectedMonthIndex));
        selectedYear = selectedYearIndex.toString();
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
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: DropdownButton<int>(
                  underline: Container(),
                  items: yearOptions,
                  value: selectedYearIndex,
                  onChanged: (val) {
                    setState(() {
                      selectedYearIndex = val!;
                      selectedYear =
                          DateFormat('YYYY').format(DateTime(0, val));
                    });
                  },
                ),
              ),
              Expanded(
                child: DropdownButton<int>(
                  underline: Container(),
                  items: monthsOptions,
                  value: selectedMonthIndex,
                  onChanged: (val) {
                    setState(() {
                      selectedMonthIndex = val!;
                      selectedMonth =
                          DateFormat('MMMM').format(DateTime(0, val));
                    });
                  },
                ),
              ),
              const SizedBox(width: 20),
              /*Expanded(
                child: DropdownButton<String>(
                  underline: Container(),
                  items: _yearList.map((e) {
                    return DropdownMenuItem<String>(value: e, child: Text(e));
                  }).toList(),
                  value: selectedYear,
                  onChanged: (val) {
                    setState(() {
                      selectedYear = val ?? "";
                    });
                  },
                ),
              ) */
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
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    // save your value
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
