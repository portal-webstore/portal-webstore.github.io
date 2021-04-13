import 'package:flutter/material.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';
import 'package:testable_web_app/webstore/catalogue/product/widgets/product_detail_widget.dart';

const edgeInsetsPadding = EdgeInsets.fromLTRB(24, 16, 24, 16);

class OrderForm extends StatefulWidget {
  const OrderForm({
    Key? key,
  }) : super(key: key);

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  ProductModel? _productDetailsToShow;

  @override
  Widget build(BuildContext context) {
    final ProductModel? productDetail = _productDetailsToShow;

    return Column(
      children: [
        Container(
          padding: edgeInsetsPadding,
        ),
        // Blank it vs possible visibility tween
        Visibility(
          visible: productDetail != null,
          child: _showValidProductDetail(
            _productDetailsToShow,
          ),
        ),
      ],
    );
  }

  Widget _showValidProductDetail(ProductModel? product) {
    if (product == null) {
      return Container();
    }
    return ProductDetail(
      productData: product,
      onTap: () {},
    );
  }

  int getNumberOfDrugDoseFieldsFromProduct(ProductModel? product) {
    if (product == null) {
      return 0;
    }

    return product.drugs.length;
  }
}
