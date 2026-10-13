/// День календаря: число [day] месяца [month] года [year].
///
/// Прежде к дню вёл интерфейс с единственной реализацией и геттеры
/// `getYear()`, `getMonth()`, `getDay()`, а выбранный ли это день, каждый
/// виджет сравнивал по трём полям сам.
final class Day {
  final int year;

  /// Месяц — как у `DateTime`: январь — 1.
  final int month;
  final int day;

  const Day({required this.year, required this.month, required this.day});

  /// День недели — как у `DateTime`: понедельник — 1.
  int get weekday => date.weekday;

  /// Полночь этого дня.
  DateTime get date => DateTime(year, month, day);

  /// Тот же ли это день, что [other]; `null` — не тот.
  bool isSameDayAs(Day? other) =>
      other != null &&
      other.year == year &&
      other.month == month &&
      other.day == day;
}
