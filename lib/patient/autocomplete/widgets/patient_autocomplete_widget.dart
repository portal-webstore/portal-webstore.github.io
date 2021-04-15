import 'package:flutter/material.dart';
import 'package:testable_web_app/patient/models/get_patient_viewmodel.dart';
import 'package:testable_web_app/patient/models/patient_model.dart'
    show PatientModel;
import 'package:testable_web_app/shared/autocomplete/helpers/autocomplete_builders.dart';
import 'package:testable_web_app/shared/autocomplete/helpers/autocomplete_text_option.dart';
import 'package:testable_web_app/shared/autocomplete/widgets/labelled_autocomplete_options_widget.dart';

///
class PatientAutocomplete<T extends PatientModel> extends StatelessWidget {
  const PatientAutocomplete({
    Key? key,
    required this.options,
    required this.onSelected,
    required this.focusNode,
    required this.textEditingController,
  }) : super(key: key);

  /// The local options to be searched
  final Iterable<T> options;
  final void Function(T) onSelected;

  /// Potentially less useful for parent smart page component to know about
  /// Must be disposed of in parent form
  final FocusNode? focusNode;

  /// Exposes the text controller for parent smart page / form component
  /// to be able to clear, evaluate, set text more directly
  ///
  /// Controller should be stateful
  ///
  /// Must be disposed of in parent form
  ///
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    /// Use RawAutocomplete to retain access to
    /// focusNode and textEditingController for customisability
    return RawAutocomplete<T>(
      optionsBuilder: getOptionsBuilder(options),
      optionsViewBuilder: getOptionsViewBuilder(),
      onSelected: onSelected,
      displayStringForOption: getViewModel(),
      fieldViewBuilder: getFieldViewBuilder(),
      focusNode: focusNode,
      textEditingController: textEditingController,
    );
  }

  /// We can pre bake the config functions for
  /// [getOptionsBuilder]
  /// [getOptionsViewBuilder]
  /// [getViewModel]
  /// [getFieldViewBuilder]
  static AutocompleteOptionsBuilder<T>
      getOptionsBuilder<T extends PatientModel>(Iterable<T> options) {
    return LabelledAutocompleteOptions.getTryOptionsBuilder(
      options,
      (option, searchText) => AutocompleteTextOption.isSearchTextFoundInOption(
        option,
        searchText,
        getPatientViewModel,
      ),
    );
  }

  static AutocompleteOptionsViewBuilder<T>
      getOptionsViewBuilder<T extends Object>() {
    return LabelledAutocompleteOptions.getOptionsViewBuilder(
      getViewModel(),
    );
  }

  static AutocompleteOptionToString<T> getViewModel<T extends Object>() {
    return (option) => option.toString();
  }

  static AutocompleteFieldViewBuilder getFieldViewBuilder() {
    return LabelledAutocomplete.getFieldBuilder(
      labelText: 'Search patient',
    );
  }
}
