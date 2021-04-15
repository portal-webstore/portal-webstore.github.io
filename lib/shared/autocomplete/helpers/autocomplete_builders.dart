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
    );
  }

  static AutocompleteFieldViewBuilder getLabelledFieldViewBuilder(
      String labelText) {
    // ignore: prefer_function_declarations_over_variables
    final LabelledAutocompleteFieldViewBuilder preLabelledFieldViewBuilder = (
      BuildContext context,
      TextEditingController textEditingController,
      FocusNode focusNode,
      VoidCallback onFieldSubmitted,
    ) {
      return LabelledAutocompleteField(
        focusNode: focusNode,
        textEditingController: textEditingController,
        onFieldSubmitted: onFieldSubmitted,
        labelText: labelText,
      );
    };

    return preLabelledFieldViewBuilder;
  }

  /// Alternate syntax to above function [getLabelledFieldViewBuilder]
  /// Works around the lint.
  static LabelledAutocompleteFieldViewBuilder getBuilder({
    required String labelText,
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
          helperText: helperText,
        );
  }
}
