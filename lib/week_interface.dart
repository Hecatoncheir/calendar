part of 'week.dart';

abstract class WeekInterface {
  int getWeekNumberInMonth();
  int getYear();
  int getMonth();
  DayInterface? getDayOfWeek(int dayOfWeek);
  void setDayOfWeek(int dayOfWeek, DayInterface day);
  Map<int, DayInterface?> getDaysOfWeek();
}
