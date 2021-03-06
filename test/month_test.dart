import 'package:test/test.dart';
import 'package:calendar/month.dart';

void main() {
  group("Month", () {
    test("getDaysCount", () async {
      const year = 1900;
      Month month;

      month = Month(year: year, month: DateTime.january);
      expect(month.getDaysCount(), equals(31));

      month = Month(year: year, month: DateTime.february);
      expect(month.getDaysCount(), equals(28));

      month = Month(year: year, month: DateTime.march);
      expect(month.getDaysCount(), equals(31));

      month = Month(year: year, month: DateTime.april);
      expect(month.getDaysCount(), equals(30));

      month = Month(year: year, month: DateTime.may);
      expect(month.getDaysCount(), equals(31));

      month = Month(year: year, month: DateTime.june);
      expect(month.getDaysCount(), equals(30));

      month = Month(year: year, month: DateTime.july);
      expect(month.getDaysCount(), equals(31));

      month = Month(year: year, month: DateTime.august);
      expect(month.getDaysCount(), equals(31));

      month = Month(year: year, month: DateTime.september);
      expect(month.getDaysCount(), equals(30));

      month = Month(year: year, month: DateTime.november);
      expect(month.getDaysCount(), equals(30));

      month = Month(year: year, month: DateTime.december);
      expect(month.getDaysCount(), equals(31));
    });

    test("getDays", () async {
      const yearNumber = 2021;

      final month = Month(year: yearNumber, month: DateTime.may);
      final days = month.getDays();

      expect(days.length, equals(31));
      expect(days[0]?.getDay(), equals(1));

      expect(days[10]?.getDay(), equals(11));
      expect(days[10]?.getMonth(), equals(5));
      expect(days[10]?.getYear(), equals(2021));
      expect(days[10]?.getWeekday(), equals(DateTime.tuesday));
    });

    test("getFirstDaysCount", () async {
      const yearNumber = 2021;

      final month = Month(year: yearNumber, month: DateTime.may);
      final days = month.getFirstDaysCount(3);

      expect(days.length, equals(3));
      expect(days[0]?.getDay(), equals(1));
      expect(days[1]?.getDay(), equals(2));
      expect(days[2]?.getDay(), equals(3));
    });

    test("getFirstDaysCount", () async {
      const yearNumber = 2021;

      final month = Month(year: yearNumber, month: DateTime.may);
      final days = month.getLastDaysCount(3);

      expect(days.length, equals(3));
      expect(days[0]?.getDay(), equals(29));
      expect(days[1]?.getDay(), equals(30));
      expect(days[2]?.getDay(), equals(31));
    });

    test("buildWeeks", () async {
      const yearNumber = 2021;

      final month = Month(year: yearNumber, month: DateTime.may);
      final weeks = month.getWeeks();

      expect(weeks.length, equals(6));

      expect(weeks.first.getDayOfWeek(DateTime.monday), isNull);
      expect(weeks.first.getWeekNumberInMonth(), equals(1));
      expect(weeks[0].getWeekNumberInMonth(), equals(1));
      expect(weeks[0].getDayOfWeek(DateTime.monday), isNull);
      expect(weeks[0].getDayOfWeek(DateTime.saturday)?.getDay(), equals(1));

      expect(weeks[1].getDayOfWeek(DateTime.monday)?.getDay(), equals(3));

      expect(weeks[5].getDayOfWeek(DateTime.monday)?.getDay(), equals(31));
      expect(weeks.last.getDayOfWeek(DateTime.monday)?.getDay(), equals(31));
    });

    test("buildWeeks", () async {
      const yearNumber = 2022;

      final month = Month(year: yearNumber, month: DateTime.january);
      final weeks = month.getWeeks();

      expect(weeks.length, equals(6));

      expect(weeks.first.getWeekNumberInMonth(), equals(1));
      expect(weeks.first.getDayOfWeek(DateTime.monday), isNull);
      expect(weeks.first.getDayOfWeek(DateTime.sunday)?.getDay(), equals(2));

      expect(weeks[1].getWeekNumberInMonth(), equals(2));
      expect(weeks[1].getDayOfWeek(DateTime.sunday)?.getDay(), equals(9));
    });

    test('can return number of weeks', () async {
      const yearNumber = 2021;

      final month = Month(year: yearNumber, month: DateTime.may);
      final numberOfWeeks = month.getNumberOfWeeks();

      expect(numberOfWeeks, equals(6));
    });
  });
}
