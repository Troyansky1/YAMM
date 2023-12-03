import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/transaction_controllers.dart';

class DateEntry extends StatefulWidget {
  final TransactionControllers controllers;
  const DateEntry({super.key, required this.controllers});

  @override
  State<DateEntry> createState() => _DateEntryState();
}

class _DateEntryState extends State<DateEntry> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controllers.dateCont,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          icon: Icon(Icons.calendar_today),
          labelText: 'Date'),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2125)); //end date

        if (pickedDate != null) {
          //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate =
              DateFormat('yyyy-MM-dd kk:mm').format(pickedDate);
          //formatted date output using intl package =>  2021-03-16
          setState(() {
            widget.controllers.dateCont.text =
                formattedDate; //set output date to TextField value.
          });
        } else {}
      },
    );
  }
}
