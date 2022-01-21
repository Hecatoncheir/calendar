import 'package:calendar/calendar.dart';

part 'week_interface.dart';

class Week implements WeekInterface {
  final int _weekNumberInMonth;
  final Map<int, DayInterface?> _days;

  Week({
    required int weekNumberInMonth,
    required Map<int, DayInterface?> days,
  })  : _weekNumberInMonth = weekNumberInMonth,
        _days = days;

  @override
  int getWeekNumberInMonth() => _weekNumberInMonth;

  @override
  DayInterface? getDayOfWeek(int dayOfWeek) => _days[dayOfWeek];

  @override
  Map<int, DayInterface?> getDaysOfWeek() => _days;

  @override
  void setDayOfWeek(int dayOfWeek, DayInterface day) => _days[dayOfWeek] = day;
}
