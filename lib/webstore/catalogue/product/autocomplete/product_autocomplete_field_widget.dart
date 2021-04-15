import 'package:flutter/material.dart';
import 'package:testable_web_app/shared/autocomplete/helpers/autocomplete_builders.dart';
import 'package:testable_web_app/shared/autocomplete/helpers/autocomplete_text_option.dart';
import 'package:testable_web_app/shared/autocomplete/widgets/labelled_autocomplete_options_widget.dart'
    show LabelledAutocompleteOptions;
import 'package:testable_web_app/webstore/catalogue/product/autocomplete/types/product_autocomplete_types.dart'
    show
        ProductAutocompleteOnSelected,
        ProductAutocompleteOptionToString,
        ProductAutocompleteOptionsBuilder,
        ProductAutocompleteOptionsViewBuilder;
import 'package:testable_web_app/webstore/catalogue/product/models/get_product_viewmodel.dart'
    show getProductViewModel;
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart'
    show ProductModel;

class ProductAutocompleteField extends StatelessWidget {
  const ProductAutocompleteField({
    Key? key,
    required this.options,
    required this.onSelected,
    required this.focusNode,
    required this.textEditingController,
  }) : super(key: key);

  /// Base options
  final Iterable<ProductModel> options;

  final ProductAutocompleteOnSelected? onSelected;

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
    return RawAutocomplete<ProductModel>(
      optionsBuilder: getProductOptionsBuilder(),
      optionsViewBuilder: getProductOptionsViewBuilder(),
      onSelected: onSelected,
      displayStringForOption: getProductViewModel,
      fieldViewBuilder: getFieldViewBuilder(),
      focusNode: focusNode,
      textEditingController: textEditingController,
    );
  }

  ProductAutocompleteOptionsBuilder getProductOptionsBuilder() {
    return LabelledAutocompleteOptions.getTryOptionsBuilder(
      options,
      isSearchTextFoundInProductOption,
    );
  }

  /// Builder from text editing value search text.
  Iterable<ProductModel> productOptionsBuilder(
    TextEditingValue text,
  ) {
    try {
      final String searchText = text.text;
      if (searchText.trim().isEmpty) {
        return [];
      }

      final Iterable<ProductModel> searchedOptions = options.where(
        (ProductModel option) => isSearchTextFoundInProductOption(
          option,
          searchText,
        ),
      );

      return searchedOptions;
    } on Exception catch (exc) {
      // In case runtime craziness occurs.
      debugPrint(exc.toString());
    }

    return [];
  }

  ProductAutocompleteOptionsViewBuilder getProductOptionsViewBuilder() {
    return LabelledAutocompleteOptions.getOptionsViewBuilder(
      getProductViewModel,
    );
  }

  /// Alternative to above
  /// [getProductOptionsViewBuilder]
  /// code maintainability reusability trade-off vs readability at point.
  ///
  Widget productOptionsViewBuilder(
    BuildContext context,
    AutocompleteOnSelected<ProductModel> onSelected,
    Iterable<ProductModel> options,
  ) {
    return LabelledAutocompleteOptions(
      displayStringForOption: getProductViewModel,
      onSelected: onSelected,
      options: options,
    );
  }

  static bool isSearchTextFoundInProductOption(
    ProductModel option,
    String searchText,
  ) {
    return AutocompleteTextOption.isSearchTextFoundInOption(
      option,
      searchText,
      getProductViewModel,
    );
  }

  /// Get searched options based on whether the exact text is found
  /// within each option's text
  ///
  /// Note potentially unsorted lazy-load iterable rather than sorted eager list
  ///
  /// ```dart
  /// return getOptionsFilteredBy(
  ///   options,
  ///   searchText,
  ///   isSearchTextFoundInProductOption,
  /// );
  ///
  /// // vs
  ///
  /// return getOptionsFilteredBy(
  ///   options,
  ///   searchText,
  ///   isSearchTextFoundInProductOption,
  /// );
  /// ```
  ///
  Iterable<ProductModel> optionsSearchedByText(
    String searchText,
    Iterable<ProductModel> options,
  ) {
    /* 
    return options.where(
      (ProductModel option) => isSearchTextFoundInProductOption(
        option,
        searchText,
      ),
    );
    */

    /// Reusing genericised autocomplete utility helper for minimal code
    /// maintainability benefit until we start to have dozens of these
    /// Enforce same pattern
    ///
    /// Trade-off reusability vs extensive customisation
    ///
    return AutocompleteTextOption.getOptionsFilteredBy(
      options,
      searchText,
      isSearchTextFoundInProductOption,
    );
  }

  static AutocompleteFieldViewBuilder getFieldViewBuilder() {
    return LabelledAutocomplete.getBuilder(
      labelText: 'Search product',
    );
  }
}
