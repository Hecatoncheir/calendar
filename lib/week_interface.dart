part of 'week.dart';

abstract class WeekInterface {
  int getWeekNumberInMonth();
  DayInterface? getDayOfWeek(int dayOfWeek);
  void setDayOfWeek(int dayOfWeek, DayInterface day);
  Map<int, DayInterface?> getDaysOfWeek();
}
