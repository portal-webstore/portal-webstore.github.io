/// Get last day of the month so we can enforce UX inputs
/// e.g. no thirteenth month
/// Otherwise Dart may implicitly wrap it.
/// Maybe we can reuseDateTime parse instead?
///
/// Providing a zero day for the next month gives the last day of desired month
/// Providing extra day values for a month wraps to the next month
/// (month + 1) % 12 (wrap around 12)
/// Datetime constructor also wraps months so we do not need to handle mod %
///
/// need the year for the leap month days.
/// Would either need the DateTime year month or pass in two params year month
DateTime getLastDayOfMonth(DateTime monthedDate) {
  final int year = monthedDate.year;
  final int month = monthedDate.month;
  final int nextMonthToBeZeroDayed = month + 1;

  final int zeroDayToGetLastMonthLastDay = 0;

  final DateTime zeroDayEquivalentLastDayOfPreviousMonth = DateTime(
    year,
    nextMonthToBeZeroDayed,
    zeroDayToGetLastMonthLastDay,
  );

  return zeroDayEquivalentLastDayOfPreviousMonth;
}
