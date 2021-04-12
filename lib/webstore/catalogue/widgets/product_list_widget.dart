import 'package:flutter/material.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';
import 'package:testable_web_app/webstore/catalogue/product/widgets/product_list_tile_widget.dart'
    show ProductListTile;

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.productData,
  }) : super(key: key);

  final ProductModel productData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _listItemBuilder,
    );
  }

  Widget _listItemBuilder(
    BuildContext context,
    int count,
  ) {
    return ProductListTile(
      name: productData.productName,
      onTap: () {
        // Navigate to screen with a given settings args for the product data
      },
    );
  }
}
