extension Additional on DateTime {
  bool isLeapYear() => year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);

  int daysInMonthCount() {
    final monthLength = <int, int>{
      DateTime.january: 31,
      DateTime.february: isLeapYear() ? 29 : 28,
      DateTime.march: 31,
      DateTime.april: 30,
      DateTime.may: 31,
      DateTime.june: 30,
      DateTime.july: 31,
      DateTime.august: 31,
      DateTime.september: 30,
      DateTime.october: 31,
      DateTime.november: 30,
      DateTime.december: 31,
    };

    return monthLength[month]!;
  }
}
