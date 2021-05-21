import 'package:test/test.dart';
import 'package:calendar/calendar.dart';

void main() {
  group("Calendar", () {
    test("forNow", () async {
      final calendar = Calendar.forNow();
      expect(calendar.getSelectedMonth(), isNotNull);
      expect(calendar.getSelectedYear(), isNotNull);
      expect(calendar.selectPrevMonth(), isNotNull);
      expect(calendar.selectNextMonth(), isNotNull);
    });

    test("forYear", () async {
      final calendar = Calendar.forYear(year: 2021);
      expect(calendar.getSelectedYear().getYear(), equals(2021));
      expect(calendar.getSelectedMonth(), isNotNull);
      expect(calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january));
      expect(calendar.selectPrevMonth(), isNotNull);
      expect(calendar.selectNextMonth(), isNotNull);
    });

    test("selectMonth", () async {
      final calendar = Calendar.forYear(year: 2021);
      expect(calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january));
      expect(calendar.selectMonth(15), isNull);
      expect(calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january));
    });

    test("selectMonth", () async {
      final calendar = Calendar.forYear(year: 2021);
      expect(calendar.selectMonth(2), isNotNull);
      expect(
          calendar.selectMonth(2)?.getMonthNumber(), equals(DateTime.february));

      expect(calendar.getSelectedMonth(), isNotNull);
      expect(calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.february));

      final prevMonth = calendar.selectPrevMonth();
      expect(prevMonth, isNotNull);
      expect(prevMonth.getMonthNumber(), equals(DateTime.january));
      expect(prevMonth.getYear(), equals(2021));

      final nextMonth = calendar.selectNextMonth();
      expect(nextMonth, isNotNull);
      expect(nextMonth.getMonthNumber(), equals(DateTime.february));
      expect(nextMonth.getYear(), equals(2021));

      final newNextMonth = calendar.selectNextMonth();
      expect(newNextMonth, isNotNull);
      expect(newNextMonth.getMonthNumber(), equals(DateTime.march));
      expect(newNextMonth.getYear(), equals(2021));
    });

    test("selectMonth", () async {
      final calendar = Calendar.forYear(year: 2021);
      expect(calendar.selectMonth(1), isNotNull);
      expect(
          calendar.selectMonth(1)?.getMonthNumber(), equals(DateTime.january));

      expect(calendar.getSelectedMonth(), isNotNull);
      expect(calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january));

      final prevMonth = calendar.selectPrevMonth();
      expect(prevMonth, isNotNull);
      expect(prevMonth.getMonthNumber(), equals(DateTime.december));
      expect(prevMonth.getYear(), equals(2020));

      final nextMonth = calendar.selectNextMonth();
      expect(nextMonth, isNotNull);
      expect(nextMonth.getMonthNumber(), equals(DateTime.january));
      expect(nextMonth.getYear(), equals(2021));

      expect(calendar.selectMonth(12), isNotNull);
      expect(calendar.selectMonth(12)?.getMonthNumber(),
          equals(DateTime.december));

      expect(calendar.getSelectedMonth(), isNotNull);
      expect(calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.december));

      final newNextMonth = calendar.selectNextMonth();
      expect(newNextMonth, isNotNull);
      expect(newNextMonth.getMonthNumber(), equals(DateTime.january));
      expect(newNextMonth.getYear(), equals(2022));
    });

    test("selectYear", () async {
      final calendar = Calendar.forYear(year: 2021);
      expect(calendar.getSelectedYear().getYear(), equals(2021));
      expect(calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january));
      expect(calendar.selectYear(2022)?.getYear(), equals(2022));
      expect(calendar.getSelectedYear().getYear(), equals(2022));
      expect(calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january));
    });

    test("selectNextYear", () async {
      final calendar = Calendar.forYear(year: 2021);
      expect(calendar.selectNextYear().getYear(), equals(2022));
      expect(calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january));
      expect(calendar.getSelectedYear().getYear(), equals(2022));
      expect(calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january));
    });

    test("selectPrevYear", () async {
      final calendar = Calendar.forYear(year: 2021);
      expect(calendar.selectPrevYear().getYear(), equals(2020));
      expect(calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january));
      expect(calendar.getSelectedYear().getYear(), equals(2020));
      expect(calendar.getSelectedMonth().getMonthNumber(),
          equals(DateTime.january));
    });
    test("getFullWeeksOfSelectedMonth", () async {
      final calendar = Calendar.forMonth(year: 2021, month: DateTime.may);

      final weeks = calendar.getFullWeeksOfSelectedMonth();

      expect(weeks.length, equals(6));
      expect(weeks[1]!.length, equals(7));
      expect(weeks.values.last.length, equals(7));

      final firstDayOfAprilInFirstWeek = weeks[1]![DateTime.monday]!;
      expect(firstDayOfAprilInFirstWeek, isNotNull);
      expect(firstDayOfAprilInFirstWeek.getDay(), equals(26));
      expect(firstDayOfAprilInFirstWeek.getMonth(), equals(DateTime.april));

      final firstDayOfMayInFirstWeek = weeks.values.first[DateTime.saturday]!;
      expect(firstDayOfMayInFirstWeek, isNotNull);
      expect(firstDayOfMayInFirstWeek.getDay(), equals(1));
      expect(firstDayOfMayInFirstWeek.getMonth(), equals(DateTime.may));

      final lastDayOfMayInLastWeek = weeks[6]![DateTime.monday]!;
      expect(lastDayOfMayInLastWeek, isNotNull);
      expect(lastDayOfMayInLastWeek.getDay(), equals(31));
      expect(lastDayOfMayInLastWeek.getMonth(), equals(DateTime.may));

      final firstDayOfJuneInLastWeek = weeks[6]![DateTime.tuesday]!;
      expect(firstDayOfJuneInLastWeek, isNotNull);
      expect(firstDayOfJuneInLastWeek.getDay(), equals(1));
      expect(firstDayOfJuneInLastWeek.getMonth(), equals(DateTime.june));
    });

    test("getFullWeeksOfSelectedMonth", () async {
      final calendar = Calendar.forMonth(year: 2021, month: DateTime.may);

      final weeks = calendar.getFullWeeksOfSelectedMonth();

      final firstWeek = weeks[1]!;
      final firstWeekMonday = firstWeek[DateTime.monday]!;
      expect(firstWeekMonday.getDay(), equals(26));
      expect(firstWeekMonday.getMonth(), equals(DateTime.april));

      final firstWeekTuesday = firstWeek[DateTime.tuesday]!;
      expect(firstWeekTuesday.getDay(), equals(27));
      expect(firstWeekTuesday.getMonth(), equals(DateTime.april));

      final firstWeekWednesday = firstWeek[DateTime.wednesday]!;
      expect(firstWeekWednesday.getDay(), equals(28));
      expect(firstWeekWednesday.getMonth(), equals(DateTime.april));

      final firstWeekThursday = firstWeek[DateTime.thursday]!;
      expect(firstWeekThursday.getDay(), equals(29));
      expect(firstWeekThursday.getMonth(), equals(DateTime.april));

      final firstWeekFriday = firstWeek[DateTime.friday]!;
      expect(firstWeekFriday.getDay(), equals(30));
      expect(firstWeekFriday.getMonth(), equals(DateTime.april));

      final firstWeekSaturday = firstWeek[DateTime.saturday]!;
      expect(firstWeekSaturday.getDay(), equals(1));
      expect(firstWeekSaturday.getMonth(), equals(DateTime.may));

      final firstWeekSunday = firstWeek[DateTime.sunday]!;
      expect(firstWeekSunday.getDay(), equals(2));
      expect(firstWeekSunday.getMonth(), equals(DateTime.may));
    });

    test("selectDay", () async {
      final calendar = Calendar.forMonth(year: 2021, month: 5);
      expect(calendar.getSelectedDay(), isNull);
    });

    test("selectDay", () async {
      final calendar = Calendar.forMonth(year: 2021, month: 5);
      expect(calendar.getSelectedYear().getYear(), equals(2021));
      expect(
        calendar.getSelectedMonth().getMonthNumber(),
        equals(DateTime.may),
      );

      expect(calendar.selectDay(2021, 5, -1), isNull);
      expect(calendar.selectDay(2021, 5, 2)!.getYear(), equals(2021));
      expect(calendar.selectDay(2021, 6, 2)!.getMonth(), equals(6));
      expect(calendar.selectDay(2021, 5, 2)!.getDay(), equals(2));

      expect(calendar.selectDay(2022, 5, 2)!.getYear(), equals(2022));
      expect(calendar.getSelectedYear().getYear(), equals(2022));
      expect(calendar.getSelectedMonth().getMonthNumber(), equals(5));
      expect(calendar.getSelectedDay()!.getDay(), equals(2));
    });
  });
}
