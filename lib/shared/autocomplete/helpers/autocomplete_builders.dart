import 'package:flutter/material.dart';
import 'package:testable_web_app/shared/autocomplete/widgets/labelled_autocomplete_field_widget.dart';

typedef LabelledAutocompleteFieldViewBuilder = LabelledAutocompleteField
    Function(
  BuildContext context,
  TextEditingController textEditingController,
  FocusNode focusNode,
  VoidCallback onFieldSubmitted,
);

class LabelledAutocomplete {
  static Widget labelledFieldViewBuilder(
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
    VoidCallback onFieldSubmitted,
  ) {
    return LabelledAutocompleteField(
      focusNode: focusNode,
      textEditingController: textEditingController,
      onFieldSubmitted: onFieldSubmitted,
      labelText: 'Search patient',
      isEnabled: true,
    );
  }

  /// Alternate syntax to above function [getLabelledFieldViewBuilder]
  /// Works around the lint.
  ///
  /// added isTextFieldEnabled for more UI flexibility of hiding vs disabling
  /// Disabling shows the standard form state rather than hiding completely.
  static LabelledAutocompleteFieldViewBuilder getFieldBuilder({
    required String labelText,
    bool isTextFieldEnabled = true,
    String helperText = '',
  }) {
    return (
      BuildContext context,
      TextEditingController textEditingController,
      FocusNode focusNode,
      VoidCallback onFieldSubmitted,
    ) =>
        LabelledAutocompleteField(
          focusNode: focusNode,
          textEditingController: textEditingController,
          onFieldSubmitted: onFieldSubmitted,
          labelText: labelText,
          isEnabled: isTextFieldEnabled,
          helperText: helperText,
        );
  }
}
