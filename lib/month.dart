import 'package:meta/meta.dart';

import 'day.dart';
import 'extensions.dart';

abstract class MonthInterface {
  int getDaysCount();
  List<Day?> getDays();
  int getMonthNumber();
  int getYear();
  List<Day?> getFirstDaysCount(int count);
  List<Day?> getLastDaysCount(int count);
  Map<int, Map<int, Day?>> getWeeks();
}

class Month implements MonthInterface {
  final int _month;
  @override
  int getMonthNumber() => _month;

  final int _year;
  @override
  int getYear() => _year;

  final int _daysCount;
  @override
  int getDaysCount() => _daysCount;

  late final List<Day?> _days;
  @override
  List<Day?> getDays() => _days;

  late final Map<int, Map<int, Day?>> _weeks;
  @override
  Map<int, Map<int, Day?>> getWeeks() => _weeks;

  Month({
    required int year,
    required int month,
  })  : _year = year,
        _month = month,
        _daysCount = DateTime(year, month).daysInMonthCount() {
    _days = buildDays(_daysCount);
    _weeks = buildWeeks(_days);
  }

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
  Map<int, Map<int, Day?>> buildWeeks(List<Day?> days) {
    final weeks = <int, Map<int, Day?>>{};

    int weekNumber = 1;
    Map<int, Day?> week = <int, Day?>{};
    weeks[weekNumber] = week;

    for (final day in days) {
      if (day == null) continue;

      weeks[weekNumber]![day.getWeekday()] = day;

      if (day.getWeekday() == DateTime.sunday) {
        weekNumber++;
        week = <int, Day?>{};
        weeks[weekNumber] = week;
      }
    }

    return weeks;
  }

  @override
  List<Day?> getFirstDaysCount(int count) => _days.getRange(0, count).toList();

  @override
  List<Day?> getLastDaysCount(int count) =>
      _days.getRange(_days.length - count, _days.length).toList();
}
