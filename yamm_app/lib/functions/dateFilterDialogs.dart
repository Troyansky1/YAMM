import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/user_preferences.dart';

updatePickedDate(
    TransactionsListsNotifier transactionsListsNotifier, DateTime? pickedDate) {
  if (pickedDate?.year != null) {
    transactionsListsNotifier.filters.value.yearFilter = pickedDate!.year;
    transactionsListsNotifier.notify();
  }
  if (pickedDate?.month != null) {
    transactionsListsNotifier.filters.value.monthFilter = pickedDate!.month;
    transactionsListsNotifier.notify();
  }
  if (pickedDate?.day != null) {
    transactionsListsNotifier.filters.value.dayFilter = pickedDate!.day;
    transactionsListsNotifier.notify();
  }
}

String getDateFormat(DateFrames dateFrame) {
  String dateFormat = '';
  if (dateFrame == DateFrames.day) {
    dateFormat = 'dd MMMM yyyy';
  } else if (dateFrame == DateFrames.month) {
    dateFormat = 'MMMM yyyy';
  } else if (dateFrame == DateFrames.year) {
    dateFormat = 'yyyy';
  }
  return dateFormat;
}

Future<void> showCustomDatePickerDialog(
    TransactionsListsNotifier transactionsListsNotifier,
    BuildContext context,
    DateFrames dateFrame) async {
  DateTime currentDate = DateTime(
      transactionsListsNotifier.filters.value.yearFilter,
      transactionsListsNotifier.filters.value.monthFilter,
      transactionsListsNotifier.filters.value.dayFilter);
  String dateFormat = getDateFormat(dateFrame);
  return DatePicker.showDatePicker(
    context,
    dateFormat: dateFormat,
    initialDateTime: currentDate,
    minDateTime: defaultStartYear,
    maxDateTime: defaultEndYear,
    onConfirm: (
      dateTime,
      List<int> index,
    ) {
      updatePickedDate(transactionsListsNotifier, dateTime);
    },
  );
}
