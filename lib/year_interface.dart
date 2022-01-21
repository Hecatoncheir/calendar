part of 'year.dart';

abstract class YearInterface {
  int getYearNumber();
  MonthInterface? getMonth(int month);
  Map<int, MonthInterface?> getAllMonths();
  Map<int, MonthInterface?> getMonths(List<int> months);
}
