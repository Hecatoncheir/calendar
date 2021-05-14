import 'package:test/test.dart';
import 'package:calendar/day.dart';

void main() {
  group("Day", () {
    test("getWeekday", () async {
      const yearNumber = 2021;
      const monthNumber = 5;
      const dayNumber = 11;

      final day = Day(year: yearNumber, month: monthNumber, day: dayNumber);
      expect(day.getWeekday(), equals(2));
      expect(day.getWeekday() == DateTime.tuesday, isTrue);
    });

    test("getWeekday", () async {
      const year = 2021;
      const month = 5;
      const dayNumber = 10;

      final day = Day(year: year, month: month, day: dayNumber);
      expect(day.getWeekday(), equals(1));
      expect(day.getWeekday() == DateTime.monday, isTrue);
    });
  });
}
