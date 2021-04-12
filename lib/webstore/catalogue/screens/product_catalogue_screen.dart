import 'package:flutter/material.dart';

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
    );
  }
}
