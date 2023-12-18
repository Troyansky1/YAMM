import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:yamm_app/user_preferences.dart';

class DateEntry extends StatefulWidget {
  final TransactionControllers controllers;
  const DateEntry({super.key, required this.controllers});

  @override
  State<DateEntry> createState() => _DateEntryState();
}

class _DateEntryState extends State<DateEntry> {
  dateTimePickerWidget(
      BuildContext context, TransactionControllers controllers) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: transactionDateFormat,
      initialDateTime: DateTime.now(),
      minDateTime: defaultStartYear,
      maxDateTime: defaultEndYear,
      minuteDivider: 10,
      onConfirm: (
        dateTime,
        List<int> index,
      ) {
        DateTime selectdate = dateTime;
        controllers.dateCont.text =
            DateFormat(presentDateFormat).format(selectdate);
        controllers.dateVal =
            DateFormat(transactionDateFormat).format(selectdate);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controllers.dateCont,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        icon: Icon(Icons.calendar_today),
        labelText: 'Time',
        contentPadding: EdgeInsets.symmetric(vertical: 1.0),
      ),
      readOnly: true,
      onTap: () async {
        dateTimePickerWidget(context, widget.controllers);
      },
    );
  }
}
