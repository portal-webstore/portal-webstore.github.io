import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart'
    show
        DefaultMaterialLocalizations,
        Locale,
        LocalizationsDelegate,
        MaterialLocalizations;

class AustralianLocalisationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const AustralianLocalisationDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      SynchronousFuture<MaterialLocalizations>(
        const CustomLocalization(),
      );

  @override
  bool shouldReload(AustralianLocalisationDelegate old) => false;

  @override
  String toString() => 'CustomLocalization.delegate(en_AU)';
}

/// Default MaterialApp implicitly uses DefaultMaterialLocalizations delegate
///
/// We are now forcing our own delegate instead.
///
/// Override samples found here
/// https://stackoverflow.com/questions/54518741/flutter-change-search-hint-text-of-searchdelegate
/// - BUG: https://github.com/flutter/flutter/issues/70341
/// Repurpose to override the dateHelpText for date mm/dd/yyyy
class CustomLocalization extends DefaultMaterialLocalizations {
  const CustomLocalization();

  /// Unused
  /// This search text is the same as the default.
  @override
  String get searchFieldLabel => 'Search';

  /// We want Australian region date format.
  ///
  /// DefaultMaterialLocalization defaults to mm/dd/yyyy regardless of device
  /// or other setting
  ///
  /// - BUG: https://github.com/flutter/flutter/issues/70341 Known Flutter bug.
  @override
  String get dateHelpText => 'dd/mm/yyyy';

  @override
  String formatCompactDate(DateTime date) {
    // Assumes Aus dd/MM/yyyy rather than  US mm/dd/yyyy format
    final day = _formatTwoDigitZeroPad(date.day);
    final month = _formatTwoDigitZeroPad(date.month);
    final year = date.year.toString().padLeft(4, '0');

    return '$day/$month/$year';
  }

  /// Adapts Australian input and reuses existing format parsers
  /// Check if InputDatePickerFormField form validators use this or other defaults.
  /// e.g. `invalidDateFormatLabel` "Invalid format"
  /// Hack into the default US region functionality
  ///
  /// Return Nullable
  /// No union type support in Dart
  /// Nullable DateTime? notation is in beta.
  @override
  DateTime? parseCompactDate(String? ausInputddMMyyyy) {
    if (ausInputddMMyyyy == null) {
      return null;
    }

    final String? rearrangedAusToUSFormat = getDateStringUSFormatFromAusFormat(
      ausInputddMMyyyy,
    );

    // See tryParse nullability logic in base DefaultMaterialLocalizations
    return super.parseCompactDate(rearrangedAusToUSFormat);
  }
}

///
String? getDateStringUSFormatFromAusFormat(String ausInputddMMyyyy) {
  final List<String> dateParts = ausInputddMMyyyy.split('/');
  if (dateParts.length != 3) {
    return null;
  }
  final String day = dateParts[0];
  final String month = dateParts[1];
  final String year = dateParts[2];

  // To reuse the default US logic rather than recreating
  // This will break if Flutter ever decides to have respective region defaults.
  final String rearrangedAusToUSFormat = '$month/$day/$year';

  return rearrangedAusToUSFormat;
}

/// Formats [number] using two digits, assuming it's in the 0-99 inclusive
/// range. Not designed to format values outside this range.
String _formatTwoDigitZeroPad(int number) {
  assert(0 <= number && number < 100);

  if (number < 10) return '0$number';

  return '$number';
}
