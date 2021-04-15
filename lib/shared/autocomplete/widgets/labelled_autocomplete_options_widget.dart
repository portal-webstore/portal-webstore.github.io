import 'package:flutter/material.dart';

class LabelledAutocompleteOptions<T extends Object> extends StatelessWidget {
  const LabelledAutocompleteOptions({
    Key? key,
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
  }) : super(key: key);

  final AutocompleteOptionToString<T> displayStringForOption;

  final AutocompleteOnSelected<T> onSelected;

  final Iterable<T> options;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0,
        child: SizedBox(
          height: 200.0,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: options.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              // AutocompleteOption

              final T option = options.elementAt(index);
              return InkWell(
                onTap: () {
                  onSelected(option);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(displayStringForOption(option)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Helper utility to get the builder
  /// Only requires the display view model getter for the option.
  ///
  ///
  /// Example:
  /// ```dart
  /// ProductAutocompleteOptionsViewBuilder getProductOptionsViewBuilder() {
  ///   return LabelledAutocompleteOptions.getOptionsViewBuilder(
  ///     getProductViewModel,
  ///   );
  /// }
  /// ```
  static AutocompleteOptionsViewBuilder<T>
      getOptionsViewBuilder<T extends Object>(
    String Function(T option) displayStringForOption,
  ) {
    return (
      BuildContext context,
      AutocompleteOnSelected<T> onSelected,
      Iterable<T> options,
    ) =>
        LabelledAutocompleteOptions(
          displayStringForOption: displayStringForOption,
          onSelected: onSelected,
          options: options,
        );
  }

  // static LabelledAutocompleteOptions getOptionsViewBuilder<T extends Object> (BuildContext context, AutocompleteOnSelected<T> onSelected, Iterable<T> options,) {

  //       return LabelledAutocompleteOptions<T>(
  //         displayStringForOption: displayStringForOption,
  //         onSelected: onSelected,
  //         options: options,
  //       );
  //     }}
}
