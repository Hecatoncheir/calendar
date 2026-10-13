import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

import 'day.dart';
import 'date_time_extension.dart';
import 'week.dart';

/// Месяц [number] года [year] — его дни и недели.
final class Month {
  final int year;

  /// Номер месяца — как у `DateTime`: январь — 1.
  final int number;

  /// С какого дня начинается неделя — как у `DateTime`.
  final int whichDayToWeekStart;

  /// Дни месяца по порядку.
  late final List<Day> days = buildDays(daysCount);

  /// Недели месяца — только с его днями; целиком, с днями соседних, их
  /// строит `fullWeeksOfMonth`.
  late final List<Week> weeks = buildWeeks(year, number, days);

  /// Неверный [whichDayToWeekStart] отвергается сразу, как и прежде, когда
  /// недели строились в конструкторе.
  Month({
    required this.year,
    required int month,
    this.whichDayToWeekStart = DateTime.monday,
  }) : number = month {
    if (whichDayToWeekStart < DateTime.monday ||
        whichDayToWeekStart > DateTime.sunday) {
      throw ArgumentError.value(
        whichDayToWeekStart,
        'whichDayToWeekStart',
        'must be a DateTime weekday from monday (1) to sunday (7)',
      );
    }
  }

  int get daysCount => DateTime(year, number).daysInMonthCount();

  /// День [number] месяца; `null` — такого в месяце нет.
  Day? day(int number) => days.firstWhereOrNull((day) => day.day == number);

  /// Первая ли неделя месяца — неделя [weekNumber].
  bool isFirstWeek(int weekNumber) => weekNumber == 1;

  /// Последняя ли неделя месяца — неделя [weekNumber].
  bool isLastWeek(int weekNumber) => weekNumber == weeks.length;

  /// Первые [count] дней месяца.
  List<Day> firstDays(int count) => days.getRange(0, count).toList();

  /// Последние [count] дней месяца.
  List<Day> lastDays(int count) =>
      days.getRange(days.length - count, days.length).toList();

  @visibleForTesting
  List<Day> buildDays(int daysCount) => [
    for (var day = 1; day <= daysCount; day++)
      Day(year: year, month: number, day: day),
  ];

  @visibleForTesting
  List<Week> buildWeeks(int year, int month, List<Day> days) => [
    for (final MapEntry(key: weekNumber, value: weekDays) in _weeksOf(
      days,
    ).entries)
      Week(year: year, month: month, number: weekNumber, days: weekDays),
  ];

  Map<int, Map<int, Day>> _weeksOf(List<Day> days) {
    final whichDayToWeekEnd = whichDayToWeekStart == DateTime.monday
        ? DateTime.sunday
        : whichDayToWeekStart - 1;

    var weekNumber = 1;
    final weeks = <int, Map<int, Day>>{weekNumber: {}};

    for (final (index, day) in days.indexed) {
      weeks[weekNumber]![day.weekday] = day;

      final hasMoreDays = index < days.length - 1;
      if (hasMoreDays && day.weekday == whichDayToWeekEnd) {
        weekNumber++;
        weeks[weekNumber] = {};
      }
    }

    return weeks;
  }
}
