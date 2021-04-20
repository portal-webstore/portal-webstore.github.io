import 'package:flutter/material.dart';

/// Our custom autocomplete field to be returned in a
/// [AutocompleteFieldViewBuilder]
class LabelledAutocompleteField extends StatelessWidget {
  const LabelledAutocompleteField({
    Key? key,
    required this.focusNode,
    required this.textEditingController,
    required this.onFieldSubmitted,
    required this.labelText,
    required this.isEnabled,
    this.helperText = '',
  }) : super(key: key);

  final FocusNode focusNode;

  /// onFieldSubmitted callback has no string passing by default
  /// to conform to the fieldViewBuilder shape
  ///
  /// Assume other methods exist
  /// e.g. text controller at least has .text access
  final VoidCallback onFieldSubmitted;

  final TextEditingController textEditingController;

  final String labelText;

  /// Whether text field being built/rendered should show as enabled
  /// For customising complex forms (order form) to allow for alternate
  /// free text subforms to popup without confusing the user too much.
  final bool isEnabled;

  final String helperText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: labelText,
        helperText: helperText,
      ),
      controller: textEditingController,
      focusNode: focusNode,
      onFieldSubmitted: (String value) {
        // No value check!
        onFieldSubmitted();
      },
      enabled: isEnabled,
    );
  }
}
