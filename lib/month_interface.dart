part of 'month.dart';

abstract class MonthInterface {
  int getDaysCount();
  List<Day?> getDays();
  Day? getDay(int dayNumber);
  int getMonthNumber();
  int getYear();
  List<Day?> getFirstDaysCount(int count);
  List<Day?> getLastDaysCount(int count);
  Map<int, Map<int, Day?>> getWeeks();
}
