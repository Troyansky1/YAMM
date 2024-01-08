import 'package:yamm_app/enum_types/category_enum.dart';

class Filters {
  int yearFilter = DateTime.now().year;
  int monthFilter = DateTime.now().month;
  int dayFilter = DateTime.now().day;
  bool filterCategories = false;
  final Map<TransactionCategory, bool> categoryFilters = {};
  bool filterLabels = false;
  final Map<String, bool> labelsFilters = {};
  bool notify = true;
}
