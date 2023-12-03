import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';

class Converters {
  static String stringToString<String>(String a) {
    return a;
  }

  static int stringToInt<R>(String a) {
    return int.parse(a);
  }

  static String intToString<int>(int a) {
    return a.toString();
  }

  static String dateToString(DateTime a) {
    final dateFormatter = DateFormat('yyyy-MM-dd – kk:mm');
    String dateString = "";
    dateString = dateFormatter.format(a);

    return dateString;
  }

  static DateTime stringToDate<R>(String a) {
    return DateTime.parse(a);
  }
}
