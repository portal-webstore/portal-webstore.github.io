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

// For another user experience alternative
// Allows the input validator to go through with a message and error-shake
// Resets field when exceeding or entering invalid input rather than blocking
// early keystrokes.
final FilteringTextInputFormatter
    resetOnExceedingTwoDecimalPlacesInputFormatter =
    FilteringTextInputFormatter.allow(
  // Add end string $
  // for text reset that prompts the error message (with validator)
  // i.e. "Invalid value detected. Please enter dose"
  // shakes the field
  //
  RegExp(r'^\d+\.?\d{0,2}$'),
);
