import 'package:flutter/material.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';
import 'package:testable_web_app/webstore/catalogue/product/seeds/products_seed.dart';
import 'package:testable_web_app/webstore/catalogue/product/widgets/product_list_tile_widget.dart'
    show ProductListTile;

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  static const List<ProductModel> products = seedProducts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _listItemBuilder,
    );
  }

  Widget _listItemBuilder(
    BuildContext context,

    /// from 0..< count (including zero, excluding lengthcount) e.g. len - 1
    int index,
  ) {
    return ProductListTile(
      name: products[index].productName,
      onTap: () {
        // Navigate to screen with a given settings args for the product data
      },
    );
  }
}
