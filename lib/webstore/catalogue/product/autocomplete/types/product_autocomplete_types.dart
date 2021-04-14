import 'package:flutter/material.dart'
    show AutocompleteOnSelected, BuildContext, TextEditingValue, Widget;
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart'
    show ProductModel;

/// Circumspect typedef.
/// Dart does not support simple type aliases typedef on typedef
/// https://github.com/dart-lang/language/issues/65
///
/// final AutocompleteOptionsBuilder<ProductModel> optionsBuilder;
///
/// * [AutocompleteOptionsBuilder]
typedef ProductAutocompleteOptionsBuilder = Iterable<ProductModel> Function(
  TextEditingValue textEditingValue,
);

/// See
///
/// `final AutocompleteOptionsViewBuilder<ProductModel> optionsViewBuilder;`
///
/// * [AutocompleteOptionsViewBuilder]
typedef ProductAutocompleteOptionsViewBuilder = Widget Function(
  BuildContext context,
  AutocompleteOnSelected<ProductModel> onSelected,
  Iterable<ProductModel> options,
);

/// final AutocompleteOnSelected<ProductModel>? onSelected;
///
/// * [AutocompleteOnSelected]
typedef ProductAutocompleteOnSelected = void Function(
  ProductModel option,
);

/// final AutocompleteOptionToString<ProductModel>? displayStringForOption;
///
/// * [AutocompleteOptionToString]
typedef ProductAutocompleteOptionToString = String Function(
  ProductModel option,
);
