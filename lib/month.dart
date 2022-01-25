import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

import 'package:calendar/week.dart';

import 'day.dart';
import 'date_time_extension.dart';

part 'month_interface.dart';

class Month implements MonthInterface {
  final int _month;
  final int _year;
  final int _daysCount;
  late final List<DayInterface?> _days;
  late final List<WeekInterface> _weeks;
  late final _numberOfWeeks;

  final _whichDayToWeekStart;

  Month({
    required int year,
    required int month,
    int whichDayToWeekStart = DateTime.monday,
  })  : _year = year,
        _month = month,
        _daysCount = DateTime(year, month).daysInMonthCount(),
        _whichDayToWeekStart = whichDayToWeekStart {
    _days = buildDays(_daysCount);
    _weeks = buildWeeks(_days);
    _numberOfWeeks = _weeks.length;
  }

  @override
  int getYear() => _year;

  @override
  int getMonthNumber() => _month;

  @override
  int getDaysCount() => _daysCount;

  @override
  List<DayInterface?> getDays() => _days;

  @override
  DayInterface? getDay(int dayNumber) =>
      _days.firstWhereOrNull((day) => day != null && day.getDay() == dayNumber);

  @override
  List<WeekInterface> getWeeks() => _weeks;

  @override
  int getNumberOfWeeks() => _numberOfWeeks;

  @visibleForTesting
  List<Day?> buildDays(int daysCount) {
    final days = <Day>[];

    for (int dayIndex = 1; dayIndex < daysCount + 1; dayIndex++) {
      final day = Day(year: _year, month: _month, day: dayIndex);
      days.add(day);
    }

    return days;
  }

  @visibleForTesting
  List<WeekInterface> buildWeeks(List<DayInterface?> days) {
    final _weeks = _buildWeeks(_whichDayToWeekStart, days);

    final weeks = <WeekInterface>[];
    for (final _weekNumber in _weeks.keys) {
      final _week = _weeks[_weekNumber];
      if (_week == null) continue;

      final week = Week(weekNumberInMonth: _weekNumber, days: _week);
      weeks.add(week);
    }

    return weeks;
  }

  @override
  List<DayInterface?> getFirstDaysCount(int count) =>
      _days.getRange(0, count).toList();

  @override
  List<DayInterface?> getLastDaysCount(int count) =>
      _days.getRange(_days.length - count, _days.length).toList();

  Map<int, Map<int, DayInterface?>> _buildWeeks(
    int whichDayToWeekStart, // TODO: use it for build weeks
    List<DayInterface?> days,
  ) {
    final weeks = <int, Map<int, DayInterface?>>{};

    int weekNumber = 1;
    Map<int, DayInterface?> week = <int, DayInterface?>{};
    weeks[weekNumber] = week;

    for (final day in days) {
      if (day == null) continue;

      weeks[weekNumber]![day.getWeekday()] = day;

      if (day.getWeekday() == DateTime.sunday) {
        weekNumber++;
        week = <int, DayInterface?>{};
        weeks[weekNumber] = week;
      }
    }

    return weeks;
  }
}
