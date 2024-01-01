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
  List<DateFrames> dateFrames = DateFrames.values;
  late DateFrames dateFrame;
  @override
  void initState() {
    super.initState();
    dateFrame = widget.transactionsListsNotifier.dateFrame.value;
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Card(
                          elevation: 0,
                          child: Row(
                            children: <Widget>[
                              const Text(
                                "View by",
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Wrap(
                                  spacing: 5.0,
                                  children: List<Widget>.generate(
                                    dateFrames.length,
                                    (int index) {
                                      return ChoiceChip(
                                        padding: EdgeInsets.zero,
                                        label: Text(
                                          '${dateFrames[index].name}',
                                        ),
                                        selected: dateFrame.index == index,
                                        onSelected: (bool selected) {
                                          setState(() {
                                            dateFrame = dateFrames[index];
                                            widget
                                                .transactionsListsNotifier
                                                .dateFrame
                                                .value = dateFrames[index];
                                            widget.transactionsListsNotifier
                                                .updateFilters(date: true);
                                          });
                                        },
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: IconButton(
                                    padding: const EdgeInsets.all(5),
                                    onPressed: () => SideSheet.right(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.4,
                                        body: filterSideSheet(
                                            transactionsListsNotifier: widget
                                                .transactionsListsNotifier),
                                        context: context),
                                    icon: const Icon(Icons.tune),
                                    iconSize: 30,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
            ),
          ],
        )
      ],
    );
  }
}
