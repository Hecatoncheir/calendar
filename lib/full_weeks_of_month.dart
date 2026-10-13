import 'day.dart';
import 'week.dart';

/// Недели месяца [month] года [year] целиком, с понедельника по
/// воскресенье: первая добрана днями прежнего месяца, последняя — днями
/// следующего. Номер недели в месяце — с единицы, год и месяц недели — те,
/// чью сетку она составляет.
///
/// Недели считаются по датам. Прежде их добирал `Calendar`: в первую неделю
/// месяца дописывал последнюю неделю прежнего, в последнюю — первую неделю
/// следующего, не глядя, есть ли там место. У месяца, начинающегося с
/// понедельника, первая неделя целиком становилась чужой — в июне 2026 года
/// не было 1–7 июня, — а у кончающегося воскресеньем так пропадала
/// последняя: в феврале 2027-го — обе.
List<Week> fullWeeksOfMonth({required int year, required int month}) {
  final first = DateTime(year, month);
  final lastDay = DateTime(year, month + 1, 0).day;

  // Понедельник первой недели — номером дня в месяце: первое число или
  // день прежнего месяца, ноль и меньше.
  final firstMonday = first.day - (first.weekday - DateTime.monday);
  final weeksCount = (lastDay - firstMonday) ~/ DateTime.daysPerWeek + 1;

  return [
    for (var index = 0; index < weeksCount; index++)
      Week(
        year: year,
        month: month,
        number: index + 1,
        days: {
          for (
            var weekday = DateTime.monday;
            weekday <= DateTime.sunday;
            weekday++
          )
            weekday: _dayOf(
              year,
              month,
              firstMonday + index * DateTime.daysPerWeek + weekday - 1,
            ),
        },
      ),
  ];
}

/// День [day] месяца [month]; день за пределами месяца — день соседнего.
Day _dayOf(int year, int month, int day) {
  final date = DateTime(year, month, day);

  return Day(year: date.year, month: date.month, day: date.day);
}
