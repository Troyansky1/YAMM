import 'package:yamm_app/category_enum.dart';

class Filters {
  final String dateFrameFilter = "";
  int yearFilter = DateTime.now().year;
  int monthFilter = DateTime.now().month;
  int dayFilter = DateTime.now().day;

  final Map<TransactionCategory, bool> categoryFilters = {};

  final Map<String, bool> labelsFilters = {};
}
