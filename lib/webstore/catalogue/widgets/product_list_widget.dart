import 'package:flutter/material.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';
import 'package:testable_web_app/webstore/catalogue/product/screens/product_detail_screen.dart'
    show ProductDetailScreen;
import 'package:testable_web_app/webstore/catalogue/product/widgets/product_list_tile_widget.dart'
    show ProductListTile;

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
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
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) => ProductDetailScreen(
              productData: products[index],
            ),
          ),
        );
      },
    );
  }
}
