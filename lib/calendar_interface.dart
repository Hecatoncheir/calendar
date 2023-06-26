part of 'calendar.dart';

abstract class CalendarInterface {
  YearInterface getSelectedYear();
  void selectYear(int year);

  YearInterface getPrevYear();
  void selectPrevYear();

  YearInterface getNextYear();
  void selectNextYear();

  MonthInterface getSelectedMonth();
  void selectMonth(int month);

  MonthInterface getPrevMonth();
  void selectPrevMonth();

  MonthInterface getNextMonth();
  void selectNextMonth();

  WeekInterface getSelectedWeek();
  void selectMonthWeek(int week);

  WeekInterface getPrevWeek();
  void selectPrevWeek();

  WeekInterface getNextWeek();
  void selectNextWeek();

  DayInterface? getSelectedDay();
  void selectDay(int year, int month, int day);

  List<WeekInterface> getFullWeeksOfPrevMonth();
  List<WeekInterface> getFullWeeksOfSelectedMonth();
  List<WeekInterface> getFullWeeksOfNextMonth();

  WeekInterface? getWeekOfDay(DayInterface day);
}
