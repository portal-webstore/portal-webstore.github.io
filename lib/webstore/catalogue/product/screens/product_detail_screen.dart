import 'package:flutter/material.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart'
    show ProductModel;
import 'package:testable_web_app/webstore/catalogue/product/widgets/product_detail_widget.dart'
    show ProductDetail;

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    Key? key,
    required this.productData,
  }) : super(key: key);

  final ProductModel productData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductDetail(
        productData: productData,
        onTap: () {},
      ),
    );
  }
}
