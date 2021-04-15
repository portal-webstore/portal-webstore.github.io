import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;
import 'package:testable_web_app/order/forms/widgets/dose_field_widget.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';
import 'package:testable_web_app/webstore/catalogue/product/widgets/product_detail_widget.dart';

const edgeInsetsPadding = EdgeInsets.fromLTRB(16, 16, 16, 16);
const maxNumTextCharacters = 1000;

class OrderForm extends StatefulWidget {
  const OrderForm({
    Key? key,
    required this.products,
    required this.patients,
  }) : super(key: key);

  final List<ProductModel> products;
  final List patients;
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  ProductModel? _productDetailsToShow;

  @override
  Widget build(BuildContext context) {
    final ProductModel? productDetail = _productDetailsToShow;

    return SingleChildScrollView(
      child: Container(
        padding: edgeInsetsPadding,
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: <Widget>[
            // - TODO: Replace with autocomplete
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Search patient',
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
              drug: widget.products[0].drugs[0],
            ),

            // - TODO: Replace
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Required date',
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
              // Note that shift arrow selection on Flutter web does not autoscroll
              //
              // Also note that multi line selection has unintuitive behaviour
              // Selecting from a line that does not have the text caret cursor on
              // it causes the field to scroll instead of selecting from that line
              // * Vertical dragging gesture override seems to be the root issue
              // You can use mouse cursor to select within one line though
              // *and multi-lines* if you initate the cursor drag selection
              // **horizontally**
              //
              // ...
              minLines: 4,
              maxLines: 6,
              maxLength: maxNumTextCharacters,
              // https://flutter.dev/docs/release/breaking-changes/use-maxLengthEnforcement-instead-of-maxLengthEnforced#default-values-of-maxlengthenforcement
              // Composition end may not be working correctly. Appears to hard-limit
              maxLengthEnforcement:
                  MaxLengthEnforcement.truncateAfterCompositionEnds,
            ),

            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Submit order to cart',
              ),
            )
          ],
        ),
      ),
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
