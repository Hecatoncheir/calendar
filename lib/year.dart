import 'month.dart';

abstract class YearInterface {
  int getYearNumber();
  Month? getMonth(int month);
  Map<int, Month?> getAllMonths();
  Map<int, Month?> getMonths(List<int> months);
}

class Year implements YearInterface {
  final int _year;
  @override
  int getYearNumber() => _year;

  late Map<int, Month?> _allMonth;
  @override
  Map<int, Month?> getAllMonths() => _allMonth;

  Year({
    required year,
  }) : _year = year {
    _allMonth = buildAllMonthOfYear(year);
  }

  Map<int, Month?> buildAllMonthOfYear(int year) {
    final months = <int, Month?>{};

    for (int monthNumber = 1; monthNumber <= 12; monthNumber++) {
      final month = Month(year: year, month: monthNumber);
      months[monthNumber] = month;
    }

    return months;
  }

  @override
  Month? getMonth(int month) => _allMonth[month];

  @override
  Map<int, Month?> getMonths(List<int> months) {
    final _months = <int, Month?>{};

    for (final monthNumber in months) {
      final month = _allMonth[monthNumber];
      _months[monthNumber] = month;
    }

    return _months;
  }
}
