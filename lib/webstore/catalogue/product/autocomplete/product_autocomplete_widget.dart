import 'package:flutter/material.dart';
import 'package:testable_web_app/shared/autocomplete/helpers/autocomplete_text_option.dart';
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

class ProductAutocomplete extends StatelessWidget {
  const ProductAutocomplete({
    Key? key,
    required this.optionsBuilder,
    required this.optionsViewBuilder,
    required this.onSelected,
    required this.displayStringForOption,
    required this.fieldViewBuilder,
    required this.focusNode,
    required this.textEditingController,
  }) : super(key: key);

  final ProductAutocompleteOptionsBuilder optionsBuilder;

  final ProductAutocompleteOptionsViewBuilder optionsViewBuilder;

  final ProductAutocompleteOnSelected? onSelected;

  final ProductAutocompleteOptionToString? displayStringForOption;

  final AutocompleteFieldViewBuilder? fieldViewBuilder;

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
    return RawAutocomplete<ProductModel>(
      optionsBuilder: optionsBuilder,
      optionsViewBuilder: optionsViewBuilder,
      onSelected: onSelected,
      displayStringForOption:
          displayStringForOption ?? RawAutocomplete.defaultStringForOption,
      fieldViewBuilder: fieldViewBuilder,
      focusNode: focusNode,
      textEditingController: textEditingController,
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
}
