/// Computes the current streak: the number of consecutive days, counting
/// back from today, that have a check-in.
///
/// Today not yet being checked in doesn't break the streak — there's still
/// time left in the day — so counting starts from today if it's already
/// checked in, otherwise from yesterday. The streak is 0 only once a full
/// day has been skipped.
int calculateCurrentStreak(
  List<DateTime> checkInDates, {
  required DateTime today,
}) {
  final days = checkInDates.map(_dayOnly).toSet();
  final todayDay = _dayOnly(today);

  var cursor = days.contains(todayDay)
      ? todayDay
      : todayDay.subtract(const Duration(days: 1));

  var streak = 0;
  while (days.contains(cursor)) {
    streak++;
    cursor = cursor.subtract(const Duration(days: 1));
  }
  return streak;
}

DateTime _dayOnly(DateTime date) => DateTime(date.year, date.month, date.day);
