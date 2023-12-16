import 'package:yamm_app/category_enum.dart';

class Filters {
  final String dateFrameFilter = "";
  final int yearFilter = DateTime.now().year;
  final int monthFilter = DateTime.now().month;
  final int dayFilter = DateTime.now().day;
  final List<TransactionCategory> categoryFilter =
      List<TransactionCategory>.empty(growable: true);
}
