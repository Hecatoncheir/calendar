import 'package:calendar/calendar.dart';

void main() {
  final month = Month(year: 2026, month: DateTime.october);
  final weeks = fullWeeksOfMonth(year: month.year, month: month.number);

  print(
    'Октябрь ${month.year}: ${month.daysCount} день, ${weeks.length} недель',
  );
  print('     Пн   Вт   Ср   Чт   Пт   Сб   Вс');
  for (final week in weeks) {
    final days = week.days.values
        .map((day) {
          final label = day.month == month.number
              ? '${day.day}'
              : '(${day.day})';
          return label.padLeft(4);
        })
        .join(' ');
    print('${week.number}: $days');
  }
  print('\nВ скобках — дни соседних месяцев.');
}
