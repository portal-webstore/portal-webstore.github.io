// Stops users from adding extra decimal '..'
import 'package:flutter/services.dart' show FilteringTextInputFormatter;

final FilteringTextInputFormatter allowDecimalInput =
    FilteringTextInputFormatter.allow(
  // Keystrokes that violate the format will not update the value
  // Cursor responds to keystrokes and will stay visible @ last position
  RegExp(r'\d+\.?\d*'),
  // Alternatively ^\d+\.?\d*$ would reset to blank on invalid extra '..'
);

// Does not work as flutter is evaluating on every keystroke and blocks partials
//
/// Allow decimal input up to two places trailing the decimal point dot .
///
/// Valid inputs:
/// - 12321312.01
/// - 123921831092832
/// - 13290812938218321.99
/// - 2001.11
/// - 2091.95
/// - 9.8
///
///
final FilteringTextInputFormatter allowDecimalTwoPlacesInput =
    FilteringTextInputFormatter.allow(
  // ^ match start of string to avoid reevaluting trailing numbers as new token
  // \d+ multiple whole digits
  // \.? Can be integer or decimal
  // \d{0,2} can have up to two decimal places after the decimal point.
  //
  // This restricts possible errant inputs to a "1001." trailing dot no number
  RegExp(r'^\d+\.?\d{0,2}'),
  // ^ to $ appears to reset the field instead of stopping further input
  // (three decimal places is blocked)

  // Alternatively ^\d+\.?\d*$ would reset to blank on invalid extra '..'
);
