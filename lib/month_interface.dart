part of 'month.dart';

abstract class MonthInterface {
  int getDaysCount();
  List<DayInterface?> getDays();
  DayInterface? getDay(int dayNumber);
  int getMonthNumber();
  int getYear();
  List<DayInterface?> getFirstDaysCount(int count);
  List<DayInterface?> getLastDaysCount(int count);
  List<WeekInterface> getWeeks();
  int getNumberOfWeeks();
  WeekInterface? getWeekOfDay(int day);
}
