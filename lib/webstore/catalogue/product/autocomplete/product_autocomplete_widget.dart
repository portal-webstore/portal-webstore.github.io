import 'package:flutter/material.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';

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

  final Iterable<ProductModel> Function(TextEditingValue text) optionsBuilder;

  final Widget Function(
    BuildContext context,
    void Function(ProductModel product) p2,
    Iterable<ProductModel> product,
  ) optionsViewBuilder;

  final void Function(
    ProductModel product,
  )? onSelected;

  final String Function(
    ProductModel product,
  )? displayStringForOption;

  final AutocompleteFieldViewBuilder? fieldViewBuilder;

  final FocusNode? focusNode;

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
}
