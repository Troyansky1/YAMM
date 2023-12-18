import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yamm_app/transactions_list.dart';
import 'package:yamm_app/widgets/year_month_day_pickers.dart';
import 'package:yamm_app/user_preferences.dart';

Future<void> showCustomDatePickerDialog(
    TransactionsListsNotifier transactionsListsNotifier,
    BuildContext context,
    DateFrames dateFrame) async {
  DateTime currentDate = DateTime.now();
  if (dateFrame == DateFrames.day) {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: defaultStartYear,
            lastDate: defaultEendYear)
        .then((pickedDate) => {
              if (pickedDate?.year != null)
                {transactionsListsNotifier.year.value = pickedDate!.year},
              if (pickedDate?.month != null)
                {transactionsListsNotifier.month.value = pickedDate!.month},
              if (pickedDate?.day != null)
                {transactionsListsNotifier.day.value = pickedDate!.day}
            });
    transactionsListsNotifier.dateFrame.value =
        transactionsListsNotifier.dateFrame.value;
  } else if (dateFrame == DateFrames.month) {
    await showDialog(
      context: context,
      //barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: PopScope(
            canPop: true,
            child: Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: YearMonthPicker(
                  transactionsListsNotifier: transactionsListsNotifier,
                  initialYear: currentDate.year,
                  startYear: defaultStartYear.year,
                  endYear: defaultEendYear.year,
                  pickMonth: true),
            ),
          ),
        );
      },
    );
  } else if (dateFrame == DateFrames.year) {
    await showDialog(
      context: context,
      //barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: PopScope(
            canPop: true,
            child: Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: YearMonthPicker(
                  transactionsListsNotifier: transactionsListsNotifier,
                  initialYear: currentDate.year,
                  startYear: defaultStartYear.year,
                  endYear: defaultEendYear.year,
                  pickMonth: false),
            ),
          ),
        );
      },
    );
  }
}