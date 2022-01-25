import 'package:meta/meta.dart';

import 'year.dart';
import 'month.dart';
import 'week.dart';
import 'day.dart';

export 'year.dart';
export 'month.dart';
export 'week.dart';
export 'day.dart';

part 'calendar_interface.dart';

class Calendar implements CalendarInterface {
  late YearInterface _selectedYear;
  late MonthInterface _selectedMonth;
  late WeekInterface _selectedWeek;

  DayInterface? _selectedDay;
  late List<WeekInterface> _fullWeeksOfSelectedMonth;

  Calendar.forYear({
    required int year,
  }) : _selectedYear = Year(year: year) {
    final _month = _selectedYear.getMonth(DateTime.january);
    if (_month == null) return;
    _selectedMonth = _month;
    _fullWeeksOfSelectedMonth = buildFullWeeksOfMonth(_month);
    _selectedWeek = _fullWeeksOfSelectedMonth.first;
  }

  Calendar.forMonth({
    required int year,
    required int month,
  }) : _selectedYear = Year(year: year) {
    final _month = _selectedYear.getMonth(month);
    if (_month == null) return;
    _selectedMonth = _month;
    _fullWeeksOfSelectedMonth = buildFullWeeksOfMonth(_month);
    _selectedWeek = _fullWeeksOfSelectedMonth.first;
  }

  Calendar.forDay({
    required int year,
    required int month,
    required int day,
  }) {
    final _year = Year(year: year);
    _selectedYear = _year;

    final _month = Month(year: year, month: month);
    _selectedMonth = _month;

    final _day = Day(year: year, month: month, day: day);
    _selectedDay = _day;

    _fullWeeksOfSelectedMonth = buildFullWeeksOfMonth(_month);
    _selectedWeek = _fullWeeksOfSelectedMonth.first;

    final weekOfDay = getWeekOfDay(_day);
    if (weekOfDay != null) _selectedWeek = weekOfDay;
  }

  @override
  YearInterface getSelectedYear() => _selectedYear;

  @override
  MonthInterface getSelectedMonth() => _selectedMonth;

  @override
  DayInterface? getSelectedDay() => _selectedDay;

  @override
  List<WeekInterface> getFullWeeksOfSelectedMonth() =>
      _fullWeeksOfSelectedMonth;

  @override
  MonthInterface getNextMonth() {
    return _selectedMonth.getMonthNumber() == DateTime.december
        ? Month(
            year: _selectedYear.getYearNumber() + 1,
            month: DateTime.january,
          )
        : Month(
            year: _selectedYear.getYearNumber(),
            month: _selectedMonth.getMonthNumber() + 1,
          );
  }

  @override
  void selectNextMonth() {
    if (_selectedMonth.getMonthNumber() == DateTime.december) {
      selectNextYear();
    } else {
      selectMonth(_selectedMonth.getMonthNumber() + 1);
    }
  }

  @override
  MonthInterface getPrevMonth() {
    return _selectedMonth.getMonthNumber() == DateTime.january
        ? Month(
            year: _selectedYear.getYearNumber() - 1,
            month: DateTime.december,
          )
        : Month(
            year: _selectedYear.getYearNumber(),
            month: _selectedMonth.getMonthNumber() - 1,
          );
  }

  @override
  void selectPrevMonth() {
    if (_selectedMonth.getMonthNumber() == DateTime.january) {
      selectPrevYear();
      selectMonth(DateTime.december);
    } else {
      selectMonth(_selectedMonth.getMonthNumber() - 1);
    }
  }

  @override
  void selectMonth(int month) {
    final _month = _selectedYear.getMonth(month);
    if (_month == null) return null;
    _selectedMonth = _month;
    _fullWeeksOfSelectedMonth = buildFullWeeksOfMonth(_selectedMonth);
    _selectedWeek = _fullWeeksOfSelectedMonth.first;
  }

  @override
  Year getNextYear() => Year(year: _selectedYear.getYearNumber() + 1);

  @override
  void selectNextYear() => selectYear(_selectedYear.getYearNumber() + 1);

  @override
  YearInterface getPrevYear() => Year(year: _selectedYear.getYearNumber() - 1);

  @override
  void selectPrevYear() => selectYear(_selectedYear.getYearNumber() - 1);

  @override
  void selectYear(int year) {
    _selectedYear = Year(year: year);
    selectMonth(DateTime.january);
  }

  @override
  void selectDay(int year, int month, int dayNumber) {
    _selectedYear = Year(year: year);
    selectMonth(month);

    final _day = _selectedMonth.getDay(dayNumber);
    if (_day == null) return;

    _selectedDay = _day;

    final weekOfDay = getWeekOfDay(_day);
    if (weekOfDay != null) _selectedWeek = weekOfDay;
  }

  @visibleForTesting
  List<WeekInterface> buildFullWeeksOfMonth(MonthInterface month) {
    final weeksOfMonth = month.getWeeks();

    /// Fill days from previous month
    final firstWeek = weeksOfMonth.first;
    final previousMonth = getPrevMonth();

    final daysInPreviousMonthInLastWeek =
        previousMonth.getWeeks().last.getDaysOfWeek().values;

    for (final day in daysInPreviousMonthInLastWeek) {
      if (day == null) break;
      firstWeek.setDayOfWeek(day.getWeekday(), day);
    }

    const daysInWeek = 7;
    final sortedFirstWeek = <int, DayInterface?>{};
    for (int dayInWeek = 1; dayInWeek <= daysInWeek; dayInWeek++) {
      sortedFirstWeek[dayInWeek] = firstWeek.getDayOfWeek(dayInWeek);
    }
    final updatedFirstWeek = Week(weekNumberInMonth: 1, days: sortedFirstWeek);
    weeksOfMonth.first = updatedFirstWeek;

    /// Fill days from next month
    final lastWeek = weeksOfMonth.last;
    final nextMonth = getNextMonth();

    final daysInNextMonthInFirstWeek =
        nextMonth.getWeeks().first.getDaysOfWeek().values;

    for (final day in daysInNextMonthInFirstWeek) {
      if (day == null) break;
      lastWeek.setDayOfWeek(day.getWeekday(), day);
    }

    return weeksOfMonth;
  }

  @override
  WeekInterface getNextWeek() {
    final weekNumber = _selectedWeek.getWeekNumberInMonth() + 1;

    if (weekNumber > _selectedMonth.getNumberOfWeeks()) {
      return getNextMonth().getWeeks().first;
    }

    return _selectedMonth
        .getWeeks()
        .firstWhere((week) => week.getWeekNumberInMonth() == weekNumber);
  }

  @override
  WeekInterface getPrevWeek() {
    final weekNumber = _selectedWeek.getWeekNumberInMonth() - 1;

    if (weekNumber < 1) {
      return getPrevMonth().getWeeks().last;
    }

    return _selectedMonth
        .getWeeks()
        .firstWhere((week) => week.getWeekNumberInMonth() == weekNumber);
  }

  @override
  WeekInterface getSelectedWeek() => _selectedWeek;

  @override
  void selectNextWeek() {
    final weekNumber = _selectedWeek.getWeekNumberInMonth() + 1;

    if (weekNumber > _selectedWeek.getWeekNumberInMonth()) {
      selectNextMonth();
      _selectedWeek = _selectedMonth.getWeeks().first;
    } else {
      _selectedWeek = _selectedMonth
          .getWeeks()
          .firstWhere((week) => week.getWeekNumberInMonth() == weekNumber);
    }
  }

  @override
  void selectPrevWeek() {
    final weekNumber = _selectedWeek.getWeekNumberInMonth() - 1;

    if (weekNumber < 1) {
      selectPrevMonth();
      _selectedWeek = _selectedMonth.getWeeks().last;
    } else {
      _selectedWeek = _selectedMonth
          .getWeeks()
          .firstWhere((week) => week.getWeekNumberInMonth() == weekNumber);
    }
  }

  @override
  void selectMonthWeek(int weekNumber) {
    if (weekNumber > _selectedMonth.getNumberOfWeeks()) return;
    if (weekNumber < 1) return;

    _selectedWeek = _selectedMonth
        .getWeeks()
        .firstWhere((week) => week.getWeekNumberInMonth() == weekNumber);
  }

  @override
  WeekInterface? getWeekOfDay(DayInterface day) {
    WeekInterface? weekOfDay;

    for (final week in _fullWeeksOfSelectedMonth) {
      for (final dayOfWeek in week.getDaysOfWeek().values) {
        if (dayOfWeek == null) continue;
        if (dayOfWeek.getMonth() != day.getMonth()) continue;
        if (dayOfWeek.getDay() != day.getDay()) continue;

        weekOfDay = week;
        break;
      }
    }

    return weekOfDay;
  }
}
