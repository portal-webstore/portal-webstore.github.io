import 'package:flutter/material.dart';
import 'package:testable_web_app/order/forms/widgets/dose_field_widget.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';
import 'package:testable_web_app/webstore/catalogue/product/seeds/products_seed.dart';
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

        // - TODO: Replace with autocomplete
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Search patient',
            helperText: '',
          ),
        ),

        ElevatedButton(
          onPressed: () {
            // setState isNewPatient
          },
          child: const Text(
            'Create new patient',
          ),
        ),

        // Could add the patient creation fields directly here for better UX

        // - TODO: Replace with product autocomplete
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Search product',
            helperText: '',
          ),
        ),

        // Blank it vs possible visibility tween
        Visibility(
          visible: productDetail != null,
          child: _showValidProductDetail(
            _productDetailsToShow,
          ),
        ),
        // - TODO: Replace with generated number of dose fields
        DoseField(
          drug: seedProducts[0].drugs[0],
        ),

        // - TODO: Replace
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Required date',
            helperText: '',
          ),
        ),

        // Free text notes
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Notes',
            helperText: '',
            alignLabelWithHint: true,
          ),
          textAlignVertical: TextAlignVertical.top,
          minLines: 4,
          maxLines: 6,
        ),

        ElevatedButton(
          onPressed: () {},
          child: const Text(
            'Submit order to cart',
          ),
        )
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
