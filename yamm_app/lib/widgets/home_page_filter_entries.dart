import 'package:flutter/material.dart';
import 'package:yamm_app/transaction.dart';

class HomePageFilters extends StatefulWidget {
  final List<Transaction>? TransactionsList;

  const HomePageFilters({super.key, required this.TransactionsList});

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
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> dateFrameOptionsEntries =
        <DropdownMenuItem<String>>[];
    for (final String dateFrame in dateFrames) {
      dateFrameOptionsEntries.add(
        DropdownMenuItem<String>(
          value: dateFrame,
          child: Text(dateFrame),
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("Show "),
            DropdownButton(
                items: dateFrameOptionsEntries,
                value: dateFrame,
                onChanged: (String? value) {
                  setState(() {
                    dateFrame = value!;
                  });
                })
          ],
        )
      ],
    );
  }
}
