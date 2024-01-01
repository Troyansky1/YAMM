import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:yamm_app/functions/dateFilterDialogs.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/widgets/home_page_filter/filter_list_side_sheet.dart';

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

    widget.transactionsListsNotifier.setCategoryMap();
    widget.transactionsListsNotifier.setLabelsMap();
  }

  Widget showDatesRange(TransactionsListsNotifier transactionsListsNotifier) {
    DateFrames dateFrame = transactionsListsNotifier.dateFrame.value;
    String str;
    int year = transactionsListsNotifier.filters.value.yearFilter;
    int month = transactionsListsNotifier.filters.value.monthFilter;
    int day = transactionsListsNotifier.filters.value.dayFilter;
    if (dateFrame == DateFrames.year) {
      str = year.toString();
    } else if (dateFrame == DateFrames.month) {
      str = DateFormat('yMMM').format(DateTime(year, month));
    } else if (dateFrame == DateFrames.day) {
      str = DateFormat('yMMMd').format(DateTime(year, month, day));
    } else {
      str = "error";
    }
    return TextButton(
        onPressed: () {
          showCustomDatePickerDialog(widget.transactionsListsNotifier, context,
              widget.transactionsListsNotifier.dateFrame.value);
        },
        child: Text(
          str,
          style: GoogleFonts.dosis(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ));
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
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.fromLTRB(17, 0, 0, 0)),
                      const Text(
                        "View by ",
                      ),
                      DropdownButton2<DateFrames>(
                          items: dateFrameOptionsEntries,
                          style: GoogleFonts.dosis(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          alignment: Alignment.topLeft,
                          buttonStyleData: const ButtonStyleData(
                              width: 90,
                              height: 50,
                              padding: EdgeInsets.only(left: 5, bottom: 2)),
                          dropdownStyleData: const DropdownStyleData(
                            width: 90,
                            scrollPadding: EdgeInsets.all(0),
                            maxHeight: 150,
                            padding: EdgeInsets.only(left: 0),
                            isOverButton: false,
                          ),
                          value:
                              widget.transactionsListsNotifier.dateFrame.value,
                          onChanged: (DateFrames? value) {
                            showCustomDatePickerDialog(
                                    widget.transactionsListsNotifier,
                                    context,
                                    value!)
                                .then((a) => setState(() {
                                      widget.transactionsListsNotifier.dateFrame
                                          .value = value;
                                      widget.transactionsListsNotifier
                                          .updateFilters(date: true);
                                    }));
                          }),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    onPressed: () => SideSheet.right(
                        width: MediaQuery.of(context).size.width / 1.4,
                        body: filterSideSheet(
                            transactionsListsNotifier:
                                widget.transactionsListsNotifier),
                        context: context),
                    child: const Icon(Icons.tune)),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: width,
              alignment: Alignment.center,
              child: ValueListenableBuilder(
                  valueListenable: widget.transactionsListsNotifier.dateFrame,
                  builder: (BuildContext context, DateFrames dateFrame,
                      Widget? child) {
                    return showDatesRange(widget.transactionsListsNotifier);
                  }),
            )
          ],
        )
      ],
    );
  }
}
