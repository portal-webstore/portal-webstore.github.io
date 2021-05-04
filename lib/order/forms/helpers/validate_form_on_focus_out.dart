import 'package:flutter/material.dart';

void validateFormOnFocusOut({
  required bool isFocusedIn,
  required GlobalKey<FormState> formKey,
}) {
  // Trigger validator on focus out
  // to handle:
  // 1. Tap out
  // 2. Tab key
  // 3. Loss of focus due to unforeseen platform issues
  // For the non-enter key event (may duplicate?) for when
  // text is input / submitted and user is "finished"

  // Kept variable here for verbosity
  // ignore: unused_local_variable
  final bool isFocusedOut = !isFocusedIn;

  if (isFocusedIn) {
    // Do nothing on entering into the field itself.
    return;
  }

  // We could run an additional check here for pristine
  // or too-early input to ignore.

  // Run the validator
  formKey.currentState?.validate();
}
