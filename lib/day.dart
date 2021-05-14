abstract class DayInterface {
  int getWeekday();
  int getYear();
  int getMonth();
  int getDay();
}

class Day implements DayInterface {
  final int _year;
  @override
  int getYear() => _year;

  final int _month;
  @override
  int getMonth() => _month;

  final int _day;
  @override
  int getDay() => _day;

  final int _weekday;
  @override
  int getWeekday() => _weekday;

  Day({
    required int year,
    required int month,
    required int day,
  })  : _year = year,
        _month = month,
        _day = day,
        _weekday = DateTime(year, month, day).weekday;
}
