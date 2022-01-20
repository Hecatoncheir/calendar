import 'month.dart';

part 'year_interface.dart';

class Year implements YearInterface {
  final int _year;
  late Map<int, Month?> _allMonth;

  Year({
    required year,
  }) : _year = year {
    _allMonth = buildAllMonthOfYear(year);
  }

  @override
  int getYearNumber() => _year;

  @override
  Map<int, Month?> getAllMonths() => _allMonth;

  Map<int, Month?> buildAllMonthOfYear(int year) {
    final months = <int, Month?>{};

    const monthInYear = 12;

    for (int monthNumber = 1; monthNumber <= monthInYear; monthNumber++) {
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
