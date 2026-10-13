import 'package:test/test.dart';
import 'package:calendar/year.dart';

void main() {
  group("Year", () {
    test("getYear", () async {
      const yearNumber = 2021;
      final year = Year(year: yearNumber);
      expect(year.number, equals(2021));
    });

    test("getMonth", () async {
      const yearNumber = 2021;
      final year = Year(year: yearNumber);
      expect(year.month(1)?.number, equals(DateTime.january));
    });

    test("getAllMonths", () async {
      const yearNumber = 2021;
      final year = Year(year: yearNumber);
      expect(year.months.length, equals(12));
    });

    test("getMonths", () async {
      const yearNumber = 2021;
      final year = Year(year: yearNumber);
      expect(year.monthsOf([1, 3]).length, equals(2));
      expect(year.monthsOf([1, 3])[1]?.number, equals(DateTime.january));
      expect(year.monthsOf([1, 3])[3]?.number, equals(DateTime.march));
    });
  });
}
