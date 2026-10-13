import 'month.dart';

/// Год [number] — его месяцы.
final class Year {
  final int number;

  /// Месяцы года по номеру — как у `DateTime`: январь — 1.
  late final Map<int, Month> months = {
    for (var month = DateTime.january; month <= DateTime.december; month++)
      month: Month(year: number, month: month),
  };

  Year({required int year}) : number = year;

  /// Месяц [number] года; `null` — такого номера нет.
  Month? month(int number) => months[number];

  /// Месяцы с номерами [numbers]; номер, которого нет, — `null`.
  Map<int, Month?> monthsOf(List<int> numbers) => {
    for (final number in numbers) number: months[number],
  };
}
