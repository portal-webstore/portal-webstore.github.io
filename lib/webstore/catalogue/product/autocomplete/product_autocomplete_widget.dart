import 'package:flutter/material.dart';
import 'package:testable_web_app/shared/autocomplete/helpers/is_search_text_found_in_option.dart'
    show isSearchTextFoundInOption;
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
    return isSearchTextFoundInOption(
      option,
      searchText,
      getProductViewModel,
    );
  }
}
