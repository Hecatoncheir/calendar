import 'day.dart';
import 'month.dart';
import 'year.dart';

abstract class CalendarInterface {
  Month getSelectedMonth();
  Month? selectMonth(int month);

  Month getPrevMonth();
  Month selectPrevMonth();

  Month getNextMonth();
  Month selectNextMonth();

  Year getSelectedYear();
  Year? selectYear(int year);

  Year getPrevYear();
  Year selectPrevYear();

  Year getNextYear();
  Year selectNextYear();

  Day? getSelectedDay();
  Day? selectDay(int year, int month, int day);

  Map<int, Map<int, Day?>> getFullWeeksOfSelectedMonth();
}
