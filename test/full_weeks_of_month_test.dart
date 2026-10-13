import 'package:calendar/calendar.dart';
import 'package:test/test.dart';

/// Недели месяца целиком — по датам, с днями соседних месяцев по краям.
///
/// Прежде недели добирал `Calendar`, дописывая в крайние недели месяца
/// крайние недели соседних, и у месяца, начинающегося с понедельника или
/// кончающегося воскресеньем, крайняя неделя подменялась чужой.
void main() {
  /// Дни недели с понедельника — «месяц.число».
  List<String> daysOf(Week week) => [
    for (final day in week.days.values) '${day.month}.${day.day}',
  ];

  test('pads the first and the last week with the neighbouring months', () {
    final weeks = fullWeeksOfMonth(year: 2021, month: DateTime.may);

    expect(weeks, hasLength(6));
    expect(daysOf(weeks.first), [
      '4.26',
      '4.27',
      '4.28',
      '4.29',
      '4.30',
      '5.1',
      '5.2',
    ]);
    expect(daysOf(weeks.last), [
      '5.31',
      '6.1',
      '6.2',
      '6.3',
      '6.4',
      '6.5',
      '6.6',
    ]);
  });

  // 1 июня 2026 года — понедельник: прежде первой неделей июня была
  // последняя неделя мая, и 1–7 июня не было нигде.
  test('keeps the first week of a month that starts on a Monday', () {
    final weeks = fullWeeksOfMonth(year: 2026, month: DateTime.june);

    expect(weeks, hasLength(5));
    expect(daysOf(weeks.first), [
      '6.1',
      '6.2',
      '6.3',
      '6.4',
      '6.5',
      '6.6',
      '6.7',
    ]);
  });

  // 31 мая 2026 года — воскресенье: прежде последней неделей мая была
  // первая неделя июня.
  test('keeps the last week of a month that ends on a Sunday', () {
    final weeks = fullWeeksOfMonth(year: 2026, month: DateTime.may);

    expect(daysOf(weeks.last), [
      '5.25',
      '5.26',
      '5.27',
      '5.28',
      '5.29',
      '5.30',
      '5.31',
    ]);
  });

  // Февраль 2027 года начинается с понедельника и кончается воскресеньем:
  // прежде от него оставались две средние недели.
  test('gives February 2027 all four of its weeks', () {
    final weeks = fullWeeksOfMonth(year: 2027, month: DateTime.february);

    expect(
      [for (final week in weeks) daysOf(week).first],
      ['2.1', '2.8', '2.15', '2.22'],
    );
    expect(daysOf(weeks.last).last, '2.28');
  });

  test('numbers the weeks from one within the month of the grid', () {
    final weeks = fullWeeksOfMonth(year: 2026, month: DateTime.september);

    expect([for (final week in weeks) week.number], [1, 2, 3, 4, 5]);
    // Последняя неделя сентября — с днями октября, но она неделя сентября.
    expect(daysOf(weeks.last), [
      '9.28',
      '9.29',
      '9.30',
      '10.1',
      '10.2',
      '10.3',
      '10.4',
    ]);
    expect(weeks.last.month, DateTime.september);
    expect(weeks.last.year, 2026);
  });

  test('takes the days of the neighbouring year with their year', () {
    final december = fullWeeksOfMonth(year: 2026, month: DateTime.december);
    final january = fullWeeksOfMonth(year: 2027, month: DateTime.january);

    final lastSunday = december.last.days[DateTime.sunday];
    expect(lastSunday?.year, 2027);
    expect(lastSunday?.month, DateTime.january);
    expect(lastSunday?.day, 3);

    final firstMonday = january.first.days[DateTime.monday];
    expect(firstMonday?.year, 2026);
    expect(firstMonday?.month, DateTime.december);
    expect(firstMonday?.day, 28);
  });

  test('gives every week all seven days, Monday first', () {
    for (var month = DateTime.january; month <= DateTime.december; month++) {
      for (final week in fullWeeksOfMonth(year: 2026, month: month)) {
        expect(week.days.keys, [
          DateTime.monday,
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
          DateTime.friday,
          DateTime.saturday,
          DateTime.sunday,
        ]);
        expect(week.days.values, hasLength(7));
      }
    }
  });
}
