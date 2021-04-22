import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show LengthLimitingTextInputFormatter, MaxLengthEnforcement;
import 'package:testable_web_app/order/forms/helpers/get_date_out_of_range_invalid_error_message.dart';
import 'package:testable_web_app/order/forms/helpers/validate_form_on_focus_out.dart';
import 'package:testable_web_app/order/forms/widgets/dose_fields_widget.dart'
    show DrugDoseFields;
import 'package:testable_web_app/patient/autocomplete/widgets/patient_autocomplete_widget.dart';
import 'package:testable_web_app/patient/forms/create_patient_form.dart';
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

/// Microoptimisations recurring cost minimisation driver
///
/// at least one byte per character
/// extended character sets go 2–4 bytes each! Emoji 😲
/// DynamoDB AWS Amplify keep batches rolled into 1KB parts for capacity units
/// Optimising for PaaS serverless cloud native services
///
///
/// limit to less than one kilobyte per treatment.
/// Notes could potentially take up more than half of the record quota sizing
///
///
/// Some slightly poor UX.
/// Usually want to afford and then cut down text
///
const maxNumTextCharacters = 255;
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

const addFutureDateIncrement = Duration(
  days: 400,
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _patientSubFormKey = GlobalKey<FormState>();

  final TextEditingController _patientAutocompleteController =
      TextEditingController();

  /// Show/hide

  /// Bloc state makes sense here to map the relevant states rather than
  /// convoluting the form "view" parts with more mappers getters
  ///
  /// Create new should hide the selection dropdown field as they are mutually
  /// exclusive.
  ///
  bool _isNewPatientEntry = false;

  /// Hide if new patient rather than selecting pre-existing.
  bool get _isPatientSelectHidden => !_isNewPatientEntry;

  /// After new patient entry saved
  /// or directly searched and selected patient
  /// Null on reset
  PatientModel? _selectedPatientOrAdHocCreated;

  /// Is new product for free text subform entry
  bool _isNewProductFreeText = false;

  /// Hide if free texting the product instead of selecting from the list.
  bool get _isProductSelectHidden => !_isNewProductFreeText;

  String? _adhocCreatedProductFreeText;

  ProductModel? _selectedProduct;

  bool get _isEveryDoseFieldHidden {
    return _selectedProduct != null || _isNewProductFreeText;
  }

  // _show/hide

  @override
  void dispose() {
    _patientAutocompleteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProductModel? productDetail = _selectedProduct;

    final futureDateMax = DateTime.now().add(
      addFutureDateIncrement,
    );

    const String dateFormatErrorMessage = 'Please enter (dd/MM/yyyy) format';
    final String dateInvalidOutOfRangeErrorMessage =
        getDateOutOfRangeInvalidErrorMessage(
      DateTime.now(),
      futureDateMax,
    );

    return SingleChildScrollView(
      child: Container(
        padding: edgeInsetsPadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: edgeInsetsFormFieldPadding,
                constraints: boxFieldWidthConstraintsStandard,

                // Quick fix with Focus for proof of behaviour
                // Can then customise the autocomplete more to allow
                // onTap onChange or other behaviours
                // to clear the selection when attempting to start a search
                // To enforce more consistent behaviour
                child: Focus(
                  onFocusChange: (focusedIn) {
                    final bool focusedOut = !focusedIn;
                    if (focusedOut) {
                      return;
                    }

                    _patientAutocompleteController.clear();
                    _selectedPatientOrAdHocCreated = null;
                  },
                  child: PatientAutocomplete<PatientModel>(
                    options: widget.patients,
                    focusNode: FocusNode(),
                    textEditingController: _patientAutocompleteController,
                    isTextFieldEnabled: _isPatientSelectHidden,
                    onSelected: (PatientModel option) {
                      // Do something
                      // Save
                      _selectedPatientOrAdHocCreated = option;

                      // Focus Product field
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // setState isNewPatient
                  setState(() {
                    _patientAutocompleteController.clear();

                    _isNewPatientEntry = true;
                    _selectedPatientOrAdHocCreated = null;
                  });
                },
                child: const Text(
                  'Enter new patient',
                ),
              ),

              Visibility(
                visible: _isNewPatientEntry,
                child: IconButton(
                  icon: const Icon(Icons.undo),
                  onPressed: () {
                    setState(() {
                      // Reset toggle
                      _isNewPatientEntry = false;

                      _selectedPatientOrAdHocCreated = null;
                      // Reset subform
                    });
                  },
                ),
              ),

              Visibility(
                visible: _isNewPatientEntry,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  // Golden ratio!
                  height: 388,
                  width: 239,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  child: CreatePatientForm(
                    formKey: _patientSubFormKey,
                  ),
                ),
              ),

              Container(
                padding: edgeInsetsFormFieldPadding,
                constraints: boxFieldWidthConstraintsLong,
                child: ProductAutocompleteField(
                  options: widget.products,
                  focusNode: FocusNode(),
                  textEditingController: TextEditingController(),
                  isTextFieldEnabled: _isProductSelectHidden,

                  // - FIXME: Add onTap or other reset to clear.
                  onSelected: (option) {
                    // Do something
                    // Save
                    _selectedProduct = option;
                  },
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isNewProductFreeText = true;
                  });
                },
                child: const Text(
                  'Enter new product details',
                ),
              ),

              Visibility(
                visible: _isNewProductFreeText,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      // Reset toggle
                      // Reset subform
                      _isNewProductFreeText = false;
                    });
                  },
                  icon: const Icon(Icons.undo),
                ),
              ),
              // Blank it vs possible visibility tween
              Visibility(
                visible: productDetail != null,
                child: _showValidProductDetail(
                  _selectedProduct,
                ),
              ),

              Container(
                padding: edgeInsetsFormFieldPadding,
                constraints: boxFieldWidthConstraintsShort,

                // - TODO: Replace with generated number of dose fields
                // Check each dose to their respective (ordered) drug
                // Array of textfield controllers or handled within widget
                child: DrugDoseFields(
                  drugs: widget.products[3].drugs,
                ),
              ),

              Container(
                padding: edgeInsetsFormFieldPadding,
                width: 60,
                // - TODO: Replace with generated number of dose fields
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Quantity',
                    helperText: '',
                  ),
                  inputFormatters: [
                    // Rather than using maxLengthEnforcement
                    // which takes up space with a 0/6 char counter.
                    LengthLimitingTextInputFormatter(6),
                  ],
                ),
              ),

              Container(
                padding: edgeInsetsFormFieldPadding,
                // 120 for date field width;
                // 240 for long error message
                width: 240,
                child: Focus(
                  onFocusChange: (bool isFocusedIn) => validateFormOnFocusOut(
                    isFocusedIn: isFocusedIn,
                    formKey: _formKey,
                  ),
                  child: CustomInputDateTextFormField(
                    firstDate: DateTime.now(),
                    lastDate: futureDateMax,
                    // Note field width
                    errorFormatText: dateFormatErrorMessage,
                    // Date range or date-selectable predicate
                    // 'Outside date range 16/04/2021–21/05/2022'
                    errorInvalidText: dateInvalidOutOfRangeErrorMessage,
                    fieldHintText: 'dd/MM/yyyy',
                    fieldLabelText: 'Required date',
                    onDateSubmitted: (date) {
                      // Only called when datetime is in valid format + range predicate
                      debugPrint('Valid date submitted');

                      // Validate input again?
                      // Or save into form model?
                      // Ideally save only in one place to prevent possible bugs
                      //
                    },
                    onTextSubmitted: (text) {
                      _formKey.currentState?.validate();
                    },
                    onDateSaved: (date) {
                      // Potentially called with invalid text? on formState.save()
                      debugPrint('Valid date saved');
                      // Save to form model
                    },
                  ),
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

  /// The visual state of a fresh patient treatment order submission page
  void _resetState() {
    _patientAutocompleteController.clear();

    _isNewPatientEntry = false;
    _selectedPatientOrAdHocCreated = null;

    _isNewProductFreeText = false;
    _adhocCreatedProductFreeText = null;

    _selectedProduct = null;
  }
}
