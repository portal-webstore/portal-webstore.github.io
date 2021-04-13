import 'package:flutter/material.dart'
    show AutocompleteOnSelected, BuildContext, TextEditingValue, Widget;
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart'
    show ProductModel;

typedef ProductAutocompleteOptionsBuilder = Iterable<ProductModel> Function(
  TextEditingValue textEditingValue,
);
typedef ProductAutocompleteOptionsViewBuilder = Widget Function(
  BuildContext context,
  AutocompleteOnSelected<ProductModel> onSelected,
  Iterable<ProductModel> options,
);
typedef ProductAutocompleteOnSelected = void Function(
  ProductModel option,
);
typedef ProductAutocompleteOptionToString = String Function(
  ProductModel option,
);
