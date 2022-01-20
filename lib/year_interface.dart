part of 'year.dart';

abstract class YearInterface {
  int getYearNumber();
  Month? getMonth(int month);
  Map<int, Month?> getAllMonths();
  Map<int, Month?> getMonths(List<int> months);
}
