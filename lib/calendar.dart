import 'package:meta/meta.dart';

import 'calendar_interface.dart';
import 'day.dart';
import 'month.dart';
import 'year.dart';

export 'calendar_interface.dart';
export 'day.dart';
export 'month.dart';
export 'year.dart';

class Calendar implements CalendarInterface {
  late Year _selectedYear;
  late Month _selectedMonth;
  Day? _selectedDay;
  late Map<int, Map<int, Day?>> _fullWeeksOfSelectedMonth;

  Calendar.forYear({
    required int year,
  }) : _selectedYear = Year(year: year) {
    _selectedMonth = _selectedYear.getMonth(DateTime.january)!;
    _fullWeeksOfSelectedMonth = buildFullWeeksOfSelectedMonth(_selectedMonth);
  }

  Calendar.forMonth({
    required int year,
    required int month,
  }) : _selectedYear = Year(year: year) {
    _selectedMonth = _selectedYear.getMonth(month)!;
    _fullWeeksOfSelectedMonth = buildFullWeeksOfSelectedMonth(_selectedMonth);
  }

  Calendar.forDay({
    required int year,
    required int month,
    required int day,
  }) {
    _selectedYear = Year(year: year);
    _selectedMonth = Month(year: year, month: month);
    _selectedDay = Day(year: year, month: month, day: day);
    _fullWeeksOfSelectedMonth = buildFullWeeksOfSelectedMonth(_selectedMonth);
  }

  @override
  Year getSelectedYear() => _selectedYear;

  @override
  Month getSelectedMonth() => _selectedMonth;

  @override
  Day? getSelectedDay() => _selectedDay;

  @override
  Map<int, Map<int, Day?>> getFullWeeksOfSelectedMonth() =>
      _fullWeeksOfSelectedMonth;

  @override
  Month getNextMonth() {
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
  Month selectNextMonth() {
    if (_selectedMonth.getMonthNumber() == DateTime.december) {
      selectNextYear();

      return _selectedMonth;
    } else {
      selectMonth(_selectedMonth.getMonthNumber() + 1);
    }

    return _selectedMonth;
  }

  @override
  Month getPrevMonth() {
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
  Month selectPrevMonth() {
    if (_selectedMonth.getMonthNumber() == DateTime.january) {
      selectPrevYear();
      selectMonth(DateTime.december);
    } else {
      selectMonth(_selectedMonth.getMonthNumber() - 1);
    }

    return _selectedMonth;
  }

  @override
  Month? selectMonth(int month) {
    final selectedMonth = _selectedYear.getMonth(month);
    if (selectedMonth == null) return null;
    _selectedMonth = selectedMonth;
    _fullWeeksOfSelectedMonth = buildFullWeeksOfSelectedMonth(_selectedMonth);

    return _selectedMonth;
  }

  @override
  Year getNextYear() => Year(year: _selectedYear.getYearNumber() + 1);

  @override
  Year selectNextYear() => selectYear(_selectedYear.getYearNumber() + 1)!;

  @override
  Year getPrevYear() => Year(year: _selectedYear.getYearNumber() - 1);

  @override
  Year selectPrevYear() => selectYear(_selectedYear.getYearNumber() - 1)!;

  @override
  Year? selectYear(int year) {
    _selectedYear = Year(year: year);
    _selectedMonth = _selectedYear.getMonth(DateTime.january)!;
    _fullWeeksOfSelectedMonth = buildFullWeeksOfSelectedMonth(_selectedMonth);

    return _selectedYear;
  }

  @override
  Day? selectDay(int year, int month, int dayNumber) {
    _selectedYear = Year(year: year);
    _selectedMonth = _selectedYear.getMonth(month)!;
    _fullWeeksOfSelectedMonth = buildFullWeeksOfSelectedMonth(_selectedMonth);
    _selectedDay = _selectedMonth.getDay(dayNumber);

    return _selectedDay;
  }

  @visibleForTesting
  Map<int, Map<int, Day?>> buildFullWeeksOfSelectedMonth(Month month) {
    final weeksOfMonth = month.getWeeks();

    /// Fill days from previous month
    final firstWeek = weeksOfMonth.values.first;
    final previousMonth = Month(
      year: _selectedMonth.getYear(),
      month: _selectedMonth.getMonthNumber() - 1,
    );

    final daysInPreviousMonthInLastWeek =
        previousMonth.getWeeks().values.last.values;

    for (final day in daysInPreviousMonthInLastWeek) {
      if (day == null) break;
      firstWeek[day.getWeekday()] = day;
    }

    const daysInWeek = 7;
    final sortedFirstWeek = <int, Day?>{};
    for (int dayInWeek = 1; dayInWeek <= daysInWeek; dayInWeek++) {
      sortedFirstWeek[dayInWeek] = firstWeek[dayInWeek];
    }
    weeksOfMonth[1] = sortedFirstWeek;

    /// Fill days from next month
    final lastWeek = weeksOfMonth.values.last;
    final nextMonth = Month(
      year: _selectedMonth.getYear(),
      month: _selectedMonth.getMonthNumber() + 1,
    );

    final daysInNextMonthInFirstWeek = nextMonth.getWeeks().values.first.values;

    for (final day in daysInNextMonthInFirstWeek) {
      if (day == null) break;
      lastWeek[day.getWeekday()] = day;
    }

    return weeksOfMonth;
  }
}
