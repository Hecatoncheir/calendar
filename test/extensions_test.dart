import 'package:test/test.dart';
import 'package:calendar/extensions.dart';

void main() {
  group("Additional extensions", () {
    test("isLeapYear", () async {
      const year = 1900;
      final dateTime = DateTime(year);
      expect(dateTime.isLeapYear(), isFalse);
    });

    test("isLeapYear", () async {
      const year = 1980;
      final dateTime = DateTime(year);
      expect(dateTime.isLeapYear(), isTrue);
    });

    test("daysInMonth", () async {
      const year = 1900;
      DateTime dateTime;

      dateTime = DateTime(year, DateTime.january);
      expect(dateTime.daysInMonthCount(), equals(31));

      dateTime = DateTime(year, DateTime.february);
      expect(dateTime.daysInMonthCount(), equals(28));

      dateTime = DateTime(year, DateTime.march);
      expect(dateTime.daysInMonthCount(), equals(31));

      dateTime = DateTime(year, DateTime.april);
      expect(dateTime.daysInMonthCount(), equals(30));

      dateTime = DateTime(year, DateTime.may);
      expect(dateTime.daysInMonthCount(), equals(31));

      dateTime = DateTime(year, DateTime.june);
      expect(dateTime.daysInMonthCount(), equals(30));

      dateTime = DateTime(year, DateTime.july);
      expect(dateTime.daysInMonthCount(), equals(31));

      dateTime = DateTime(year, DateTime.august);
      expect(dateTime.daysInMonthCount(), equals(31));

      dateTime = DateTime(year, DateTime.september);
      expect(dateTime.daysInMonthCount(), equals(30));

      dateTime = DateTime(year, DateTime.november);
      expect(dateTime.daysInMonthCount(), equals(30));

      dateTime = DateTime(year, DateTime.december);
      expect(dateTime.daysInMonthCount(), equals(31));
    });
  });
}
