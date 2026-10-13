import 'package:test/test.dart';
import 'package:calendar/month.dart';

void main() {
  group("Month", () {
    test("getDaysCount", () async {
      const year = 1900;
      Month month;

      month = Month(year: year, month: DateTime.january);
      expect(month.daysCount, equals(31));

      month = Month(year: year, month: DateTime.february);
      expect(month.daysCount, equals(28));

      month = Month(year: year, month: DateTime.march);
      expect(month.daysCount, equals(31));

      month = Month(year: year, month: DateTime.april);
      expect(month.daysCount, equals(30));

      month = Month(year: year, month: DateTime.may);
      expect(month.daysCount, equals(31));

      month = Month(year: year, month: DateTime.june);
      expect(month.daysCount, equals(30));

      month = Month(year: year, month: DateTime.july);
      expect(month.daysCount, equals(31));

      month = Month(year: year, month: DateTime.august);
      expect(month.daysCount, equals(31));

      month = Month(year: year, month: DateTime.september);
      expect(month.daysCount, equals(30));

      month = Month(year: year, month: DateTime.november);
      expect(month.daysCount, equals(30));

      month = Month(year: year, month: DateTime.december);
      expect(month.daysCount, equals(31));
    });

    test("getDays", () async {
      const yearNumber = 2021;

      final month = Month(year: yearNumber, month: DateTime.may);
      final days = month.days;

      expect(days.length, equals(31));
      expect(days[0].day, equals(1));

      expect(days[10].day, equals(11));
      expect(days[10].month, equals(5));
      expect(days[10].year, equals(2021));
      expect(days[10].weekday, equals(DateTime.tuesday));
    });

    test("getFirstDaysCount", () async {
      const yearNumber = 2021;

      final month = Month(year: yearNumber, month: DateTime.may);
      final days = month.firstDays(3);

      expect(days.length, equals(3));
      expect(days[0].day, equals(1));
      expect(days[1].day, equals(2));
      expect(days[2].day, equals(3));
    });

    test("getFirstDaysCount", () async {
      const yearNumber = 2021;

      final month = Month(year: yearNumber, month: DateTime.may);
      final days = month.lastDays(3);

      expect(days.length, equals(3));
      expect(days[0].day, equals(29));
      expect(days[1].day, equals(30));
      expect(days[2].day, equals(31));
    });

    test("buildWeeks", () async {
      const yearNumber = 2021;

      final month = Month(year: yearNumber, month: DateTime.may);
      final weeks = month.weeks;

      expect(weeks.length, equals(6));

      expect(weeks.first.days[DateTime.monday], isNull);
      expect(weeks.first.number, equals(1));
      expect(weeks[0].number, equals(1));
      expect(weeks[0].days[DateTime.monday], isNull);
      expect(weeks[0].days[DateTime.saturday]?.day, equals(1));

      expect(weeks[1].days[DateTime.monday]?.day, equals(3));

      expect(weeks[5].days[DateTime.monday]?.day, equals(31));
      expect(weeks.last.days[DateTime.monday]?.day, equals(31));
    });

    test("buildWeeks", () async {
      const yearNumber = 2022;

      final month = Month(year: yearNumber, month: DateTime.january);
      final weeks = month.weeks;

      expect(weeks.length, equals(6));

      expect(weeks.first.number, equals(1));
      expect(weeks.first.days[DateTime.monday], isNull);
      expect(weeks.first.days[DateTime.sunday]?.day, equals(2));

      expect(weeks[1].number, equals(2));
      expect(weeks[1].days[DateTime.sunday]?.day, equals(9));
    });

    test('can return number of weeks', () async {
      const yearNumber = 2021;

      final month = Month(year: yearNumber, month: DateTime.may);
      final numberOfWeeks = month.weeks.length;

      expect(numberOfWeeks, equals(6));
    });

    test('uses the configured first weekday', () {
      final month = Month(
        year: 2023,
        month: DateTime.october,
        whichDayToWeekStart: DateTime.sunday,
      );

      final weeks = month.weeks;

      expect(weeks.length, equals(5));
      expect(weeks.first.days[DateTime.sunday]?.day, equals(1));
      expect(weeks.first.days[DateTime.saturday]?.day, equals(7));
      expect(weeks.last.days[DateTime.sunday]?.day, equals(29));
    });

    test('does not append an empty week when the month ends on sunday', () {
      final month = Month(year: 2023, month: DateTime.december);

      expect(month.weeks.length, equals(5));
      expect(month.weeks.last.days[DateTime.sunday]?.day, equals(31));
    });

    test('rejects an invalid first weekday', () {
      expect(
        () =>
            Month(year: 2023, month: DateTime.october, whichDayToWeekStart: 0),
        throwsArgumentError,
      );
    });
  });
}
