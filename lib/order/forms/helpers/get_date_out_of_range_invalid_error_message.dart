import 'package:testable_web_app/i18n/date/australia_date_locale_format.dart'
    show ausFullDateDisplayFormat;

String getDateOutOfRangeInvalidErrorMessage(
  DateTime startDateMin,
  DateTime futureDateMax,
) {
  return 'Outside date range '
      '${ausFullDateDisplayFormat.format(startDateMin)}'
      '–'
      '${ausFullDateDisplayFormat.format(futureDateMax)}';
}
