import 'package:test/test.dart';
import 'package:calendar/year.dart';

void main() {
  group("Year", () {
    test("getYear", () async {
      const yearNumber = 2021;
      final year = Year(year: yearNumber);
      expect(year.getYear(), equals(2021));
    });

    test("getMonth", () async {
      const yearNumber = 2021;
      final year = Year(year: yearNumber);
      expect(year.getMonth(1)?.getMonthNumber(), equals(DateTime.january));
    });

    test("getAllMonths", () async {
      const yearNumber = 2021;
      final year = Year(year: yearNumber);
      expect(year.getAllMonths().length, equals(12));
    });

    test("getMonths", () async {
      const yearNumber = 2021;
      final year = Year(year: yearNumber);
      expect(year.getMonths([1, 3]).length, equals(2));
      expect(year.getMonths([1, 3])[1]?.getMonthNumber(),
          equals(DateTime.january));
      expect(
          year.getMonths([1, 3])[3]?.getMonthNumber(), equals(DateTime.march));
    });
  });
}
