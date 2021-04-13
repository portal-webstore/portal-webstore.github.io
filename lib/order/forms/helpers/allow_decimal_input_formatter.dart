// Stops users from adding extra decimal '..'
import 'package:flutter/services.dart' show FilteringTextInputFormatter;

final FilteringTextInputFormatter allowDecimalInput =
    FilteringTextInputFormatter.allow(
  // Keystrokes that violate the format will not update the value
  // Cursor responds to keystrokes and will stay visible @ last position
  RegExp(r'\d+\.?\d*'),
  // Alternatively ^\d+\.?\d*$ would reset to blank on invalid extra '..'
);
