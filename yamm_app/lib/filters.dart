import 'package:yamm_app/category_enum.dart';

class Filters {
  final String dateFrameFilter = "";
  int yearFilter = DateTime.now().year;
  int monthFilter = DateTime.now().month;
  int dayFilter = DateTime.now().day;
  bool filterCategories = false;
  final Map<TransactionCategory, bool> categoryFilters = {};
  bool filterLabels = false;
  final Map<String, bool> labelsFilters = {};
}
