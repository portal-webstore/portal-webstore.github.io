import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;
import 'package:testable_web_app/order/forms/widgets/dose_field_widget.dart';
import 'package:testable_web_app/patient/autocomplete/widgets/patient_autocomplete_widget.dart';
import 'package:testable_web_app/patient/models/patient_model.dart';
import 'package:testable_web_app/shared/forms/date/widgets/input_custom_date_text_field.dart';
import 'package:testable_web_app/webstore/catalogue/product/autocomplete/product_autocomplete_field_widget.dart'
    show ProductAutocompleteField;
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';
import 'package:testable_web_app/webstore/catalogue/product/widgets/product_detail_widget.dart';

const edgeInsetsPadding = EdgeInsets.fromLTRB(16, 16, 16, 16);
const edgeInsetsFormFieldPadding = EdgeInsets.symmetric(
  vertical: 16,
);
const maxNumTextCharacters = 1000;
const boxFieldWidthConstraintsStandard = BoxConstraints(
  minWidth: 480,
  maxWidth: 600,
);
const boxFieldWidthConstraintsShort = BoxConstraints(
  minWidth: 120,
  maxWidth: 240,
);
const boxFieldWidthConstraintsLong = BoxConstraints(
  minWidth: 600,
  maxWidth: 960,
);

class OrderForm extends StatefulWidget {
  const OrderForm({
    Key? key,
    required this.products,
    required this.patients,
  }) : super(key: key);

  final List<ProductModel> products;
  final List<PatientModel> patients;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: edgeInsetsFormFieldPadding,
              constraints: boxFieldWidthConstraintsStandard,

              // - TODO: Replace with autocomplete
              child: PatientAutocomplete<PatientModel>(
                options: widget.patients,
                focusNode: FocusNode(),
                textEditingController: TextEditingController(),
                onSelected: (option) {
                  // Do something
                  // Save
                },
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

            Container(
              padding: edgeInsetsFormFieldPadding,
              constraints: boxFieldWidthConstraintsLong,
              child: ProductAutocompleteField(
                options: widget.products,
                focusNode: FocusNode(),
                textEditingController: TextEditingController(),
                onSelected: (option) {
                  // Do something
                  // Save
                },
              ),
            ),

            // Blank it vs possible visibility tween
            Visibility(
              visible: productDetail != null,
              child: _showValidProductDetail(
                _productDetailsToShow,
              ),
            ),

            Container(
              padding: edgeInsetsFormFieldPadding,
              constraints: boxFieldWidthConstraintsShort,

              // - TODO: Replace with generated number of dose fields
              child: DoseField(
                drug: widget.products[0].drugs[0],
              ),
            ),

            Container(
              padding: edgeInsetsFormFieldPadding,
              width: 120,
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Required date',
                  helperText: '',
                ),
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2021, 4, 24),
                    initialEntryMode: DatePickerEntryMode.input,
                  );
                },
              ),
            ),

            CustomInputDateTextFormField(
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(
                const Duration(
                  days: 400,
                ),
              ),
              // Note field width
              errorFormatText: 'Please enter (dd/MM/yyyy) format',
              // Date range or date-selectable predicate
              errorInvalidText: 'Outside date range '
                  '${DateTime.now().toString()}'
                  '–'
                  '${DateTime.now().add(
                const Duration(
                  days: 400,
                ),
              )}',
              fieldHintText: 'Hint',
              fieldLabelText: 'Required date',
              onDateSubmitted: (date) {
                // Only called when datetime is in valid format + range predicate
                debugPrint('Valid date submitted');

                // Validate input again?
                // Or save into form model?
                // Ideally save only in one place to prevent possible bugs
              },
              onDateSaved: (date) {
                // Potentially called with invalid text? on formState.save()
                debugPrint('Valid date saved');
                // Save to form model
              },
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
