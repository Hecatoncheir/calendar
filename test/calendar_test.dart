import 'package:test/test.dart';
import 'package:calendar/calendar.dart';

void main() {
  group("Calendar", () {
    test("forNow", () async {
      final calendar = Calendar.forDay(year: 2021, month: 5, day: 9);

      expect(calendar.getSelectedYear(), isNotNull);
      expect(calendar.getSelectedMonth(), isNotNull);
      expect(calendar.getSelectedDay(), isNotNull);
      expect(calendar.getPrevMonth(), isNotNull);
      expect(calendar.getNextMonth(), isNotNull);
    });

    test("forYear", () async {
      final calendar = Calendar.forYear(year: 2021);

      expect(calendar.getSelectedYear().getYearNumber(), equals(2021));
      expect(calendar.getSelectedMonth(), isNotNull);
      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.january),
      );

      expect(calendar.getPrevMonth(), isNotNull);
      expect(calendar.getNextMonth(), isNotNull);
    });

    test("selectMonth", () async {
      final calendar = Calendar.forYear(year: 2021);

      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.january),
      );

      calendar.selectMonth(15);

      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.january),
      );
    });

    test("selectMonth", () async {
      final calendar = Calendar.forYear(year: 2021);

      calendar.selectMonth(2);

      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.february),
      );

      expect(calendar.getSelectedMonth(), isNotNull);
      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.february),
      );

      calendar.selectPrevMonth();
      final prevMonth = calendar.getSelectedMonth();
      expect(prevMonth, isNotNull);
      expect(prevMonth.getMonthNumber(), equals(DateTime.january));
      expect(prevMonth.getYear(), equals(2021));

      calendar.selectNextMonth();
      final nextMonth = calendar.getSelectedMonth();
      expect(nextMonth, isNotNull);
      expect(nextMonth.getMonthNumber(), equals(DateTime.february));
      expect(nextMonth.getYear(), equals(2021));

      calendar.selectNextMonth();
      final newNextMonth = calendar.getSelectedMonth();
      expect(newNextMonth, isNotNull);
      expect(newNextMonth.getMonthNumber(), equals(DateTime.march));
      expect(newNextMonth.getYear(), equals(2021));
    });

    test("selectMonth", () async {
      final calendar = Calendar.forYear(year: 2021);

      calendar.selectMonth(1);
      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.january),
      );

      expect(calendar.getSelectedMonth(), isNotNull);
      expect(calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january));

      calendar.selectPrevMonth();
      final prevMonth = calendar.getSelectedMonth();
      expect(prevMonth, isNotNull);
      expect(prevMonth.getMonthNumber(), equals(DateTime.december));
      expect(prevMonth.getYear(), equals(2020));

      calendar.selectNextMonth();
      final nextMonth = calendar.getSelectedMonth();
      expect(nextMonth, isNotNull);
      expect(nextMonth.getMonthNumber(), equals(DateTime.january));
      expect(nextMonth.getYear(), equals(2021));

      calendar.selectMonth(12);
      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.december),
      );

      expect(calendar.getSelectedMonth(), isNotNull);
      expect(calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.december));

      calendar.selectNextMonth();
      final newNextMonth = calendar.getSelectedMonth();
      expect(newNextMonth, isNotNull);
      expect(newNextMonth.getMonthNumber(), equals(DateTime.january));
      expect(newNextMonth.getYear(), equals(2022));
    });

    test("selectYear", () async {
      final calendar = Calendar.forYear(year: 2021);

      expect(calendar.getSelectedYear().getYearNumber(), equals(2021));
      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.january),
      );

      calendar.selectYear(2022);
      expect(calendar.getSelectedYear().getYearNumber(), equals(2022));
      expect(calendar.getSelectedYear().getYearNumber(), equals(2022));
      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.january),
      );
    });

    test("selectNextYear", () async {
      final calendar = Calendar.forYear(year: 2021);

      calendar.selectNextYear();
      expect(calendar.getSelectedYear().getYearNumber(), equals(2022));
      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.january),
      );

      expect(calendar.getSelectedYear().getYearNumber(), equals(2022));
      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.january),
      );
    });

    test("selectPrevYear", () async {
      final calendar = Calendar.forYear(year: 2021);

      calendar.selectPrevYear();
      expect(calendar.getSelectedYear().getYearNumber(), equals(2020));
      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.january),
      );
      expect(calendar.getSelectedYear().getYearNumber(), equals(2020));
      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.january),
      );
    });

    test("getFullWeeksOfSelectedMonth", () async {
      final calendar = Calendar.forMonth(year: 2021, month: DateTime.may);

      final weeks = calendar.getFullWeeksOfSelectedMonth();

      expect(weeks.length, equals(6));
      expect(weeks.first.getDaysOfWeek().length, equals(7));
      expect(weeks.last.getDaysOfWeek().length, equals(7));

      final firstDayOfAprilInFirstWeek = weeks[0].getDayOfWeek(DateTime.monday);
      expect(firstDayOfAprilInFirstWeek, isNotNull);
      expect(firstDayOfAprilInFirstWeek?.getDay(), equals(26));
      expect(firstDayOfAprilInFirstWeek?.getMonth(), equals(DateTime.april));

      final firstDayOfMayInFirstWeek =
          weeks.first.getDayOfWeek(DateTime.saturday);
      expect(firstDayOfMayInFirstWeek, isNotNull);
      expect(firstDayOfMayInFirstWeek?.getDay(), equals(1));
      expect(firstDayOfMayInFirstWeek?.getMonth(), equals(DateTime.may));

      final lastDayOfMayInLastWeek = weeks[5].getDayOfWeek(DateTime.monday);
      expect(lastDayOfMayInLastWeek, isNotNull);
      expect(lastDayOfMayInLastWeek?.getDay(), equals(31));
      expect(lastDayOfMayInLastWeek?.getMonth(), equals(DateTime.may));

      final firstDayOfJuneInLastWeek = weeks[5].getDayOfWeek(DateTime.tuesday);
      expect(firstDayOfJuneInLastWeek, isNotNull);
      expect(firstDayOfJuneInLastWeek?.getDay(), equals(1));
      expect(firstDayOfJuneInLastWeek?.getMonth(), equals(DateTime.june));
    });

    test("getFullWeeksOfSelectedMonth", () async {
      final calendar = Calendar.forMonth(year: 2021, month: DateTime.may);

      final weeks = calendar.getFullWeeksOfSelectedMonth();

      final firstWeek = weeks.first;
      final firstWeekMonday = firstWeek.getDayOfWeek(DateTime.monday);
      expect(firstWeekMonday?.getDay(), equals(26));
      expect(firstWeekMonday?.getMonth(), equals(DateTime.april));

      final firstWeekTuesday = firstWeek.getDayOfWeek(DateTime.tuesday);
      expect(firstWeekTuesday?.getDay(), equals(27));
      expect(firstWeekTuesday?.getMonth(), equals(DateTime.april));

      final firstWeekWednesday = firstWeek.getDayOfWeek(DateTime.wednesday);
      expect(firstWeekWednesday?.getDay(), equals(28));
      expect(firstWeekWednesday?.getMonth(), equals(DateTime.april));

      final firstWeekThursday = firstWeek.getDayOfWeek(DateTime.thursday);
      expect(firstWeekThursday?.getDay(), equals(29));
      expect(firstWeekThursday?.getMonth(), equals(DateTime.april));

      final firstWeekFriday = firstWeek.getDayOfWeek(DateTime.friday);
      expect(firstWeekFriday?.getDay(), equals(30));
      expect(firstWeekFriday?.getMonth(), equals(DateTime.april));

      final firstWeekSaturday = firstWeek.getDayOfWeek(DateTime.saturday);
      expect(firstWeekSaturday?.getDay(), equals(1));
      expect(firstWeekSaturday?.getMonth(), equals(DateTime.may));

      final firstWeekSunday = firstWeek.getDayOfWeek(DateTime.sunday);
      expect(firstWeekSunday?.getDay(), equals(2));
      expect(firstWeekSunday?.getMonth(), equals(DateTime.may));
    });

    test("selectDay", () async {
      final calendar = Calendar.forMonth(year: 2021, month: 5);
      expect(calendar.getSelectedDay(), isNull);
    });

    test("selectDay", () async {
      final calendar = Calendar.forMonth(year: 2021, month: 5);

      expect(calendar.getSelectedYear().getYearNumber(), equals(2021));
      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.may),
      );

      calendar.selectDay(2021, 5, -1);

      expect(calendar.getSelectedDay(), isNull);

      calendar.selectDay(2021, 5, 2);
      expect(calendar.getSelectedDay()?.getYear(), equals(2021));

      calendar.selectDay(2021, 6, 2);
      expect(calendar.getSelectedDay()?.getMonth(), equals(6));

      calendar.selectDay(2021, 5, 2);
      expect(calendar.getSelectedDay()?.getDay(), equals(2));

      calendar.selectDay(2022, 5, 2);
      expect(calendar.getSelectedDay()?.getYear(), equals(2022));
      expect(calendar.getSelectedYear().getYearNumber(), equals(2022));
      expect(calendar.getSelectedMonth().getMonthNumber(), equals(5));
      expect(calendar.getSelectedDay()?.getDay(), equals(2));
    });

    group('week', () {
      test('can select prev', () async {
        final calendar = Calendar.forMonth(year: 2022, month: DateTime.january);

        expect(
          calendar.getSelectedYear().getYearNumber(),
          equals(2022),
        );
        expect(
          calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january),
        );
        expect(calendar.getSelectedWeek().getWeekNumberInMonth(), equals(1));

        calendar.selectPrevWeek();

        expect(
          calendar.getSelectedYear().getYearNumber(),
          equals(2021),
        );

        expect(
          calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.december),
        );

        expect(calendar.getSelectedWeek().getWeekNumberInMonth(), equals(5));
      });

      test('can select prev between months', () async {
        final calendar =
            Calendar.forDay(year: 2022, month: DateTime.february, day: 1);

        expect(
          calendar.getSelectedYear().getYearNumber(),
          equals(2022),
        );
        expect(
          calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.february),
        );
        expect(
          calendar.getSelectedDay()?.getDay(),
          equals(1),
        );

        // TODO: not right week number in month
        expect(calendar.getSelectedWeek().getWeekNumberInMonth(), equals(1));

        calendar.selectPrevWeek();

        expect(
          calendar.getSelectedYear().getYearNumber(),
          equals(2022),
        );

        expect(
          calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january),
        );

        expect(calendar.getSelectedWeek().getWeekNumberInMonth(), equals(5));
      });

      test('can select next', () async {
        final calendar =
            Calendar.forMonth(year: 2021, month: DateTime.december);

        expect(
          calendar.getSelectedYear().getYearNumber(),
          equals(2021),
        );
        expect(
          calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.december),
        );
        expect(calendar.getSelectedWeek().getWeekNumberInMonth(), equals(1));

        calendar.selectNextWeek();

        expect(
          calendar.getSelectedYear().getYearNumber(),
          equals(2022),
        );

        expect(
          calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january),
        );

        expect(calendar.getSelectedWeek().getWeekNumberInMonth(), equals(1));
      });

      test('can select next between months', () async {
        final calendar =
            Calendar.forDay(year: 2022, month: DateTime.january, day: 31);

        expect(
          calendar.getSelectedYear().getYearNumber(),
          equals(2022),
        );
        expect(
          calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january),
        );
        expect(
          calendar.getSelectedDay()?.getDay(),
          equals(31),
        );
        expect(calendar.getSelectedWeek().getWeekNumberInMonth(), equals(6));

        calendar.selectNextWeek();

        expect(
          calendar.getSelectedYear().getYearNumber(),
          equals(2022),
        );

        expect(
          calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.february),
        );

        expect(calendar.getSelectedWeek().getWeekNumberInMonth(), equals(1));
      });

      test('can select', () async {
        final calendar = Calendar.forMonth(year: 2022, month: DateTime.january);

        expect(
          calendar.getSelectedYear().getYearNumber(),
          equals(2022),
        );
        expect(
          calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january),
        );
        expect(calendar.getSelectedWeek().getWeekNumberInMonth(), equals(1));
        expect(
          calendar.getSelectedWeek().getDayOfWeek(DateTime.sunday)?.getDay(),
          equals(2),
        );

        calendar.selectMonthWeek(2);

        expect(
          calendar.getSelectedYear().getYearNumber(),
          equals(2022),
        );
        expect(
          calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january),
        );
        expect(calendar.getSelectedWeek().getWeekNumberInMonth(), equals(2));
        expect(
          calendar.getSelectedWeek().getDayOfWeek(DateTime.sunday)?.getDay(),
          equals(9),
        );
      });
    });
  });
}
