part 'day_interface.dart';

class Day implements DayInterface {
  final int _year;
  final int _month;
  final int _day;
  final int _weekday;

  Day({
    required int year,
    required int month,
    required int day,
  })  : _year = year,
        _month = month,
        _day = day,
        _weekday = DateTime(year, month, day).weekday;

  @override
  int getYear() => _year;

  @override
  int getMonth() => _month;

  @override
  int getDay() => _day;

  @override
  int getWeekday() => _weekday;
}
