import 'day.dart';

/// Неделя [number] в сетке месяца [month] года [year]: дни [days] по дню
/// недели — как у `DateTime`, понедельник — 1.
///
/// Неделя неизменна. Прежде `Calendar` дописывал в неё дни соседнего
/// месяца (`setDayOfWeek`) и так подменял крайние недели месяца чужими.
final class Week {
  final int year;
  final int month;

  /// Номер недели в месяце, с единицы.
  final int number;

  /// Дни по дню недели. У недели из [Month.weeks] дней соседних месяцев нет,
  /// у недели из `fullWeeksOfMonth` есть все семь.
  final Map<int, Day> days;

  Week({
    required this.year,
    required this.month,
    required this.number,
    required Map<int, Day> days,
  }) : days = Map.unmodifiable(days);
}
