import 'package:flutter/material.dart';
import 'package:testable_web_app/webstore/catalogue/widgets/product_list_widget.dart';

class ProductCatalogueScreen extends StatelessWidget {
  const ProductCatalogueScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product catalogue'),
      ),
      body: const ProductList(),
    );
  }
}
