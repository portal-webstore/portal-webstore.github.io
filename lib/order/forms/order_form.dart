import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show LengthLimitingTextInputFormatter, MaxLengthEnforcement;
import 'package:testable_web_app/i18n/date/australia_date_locale_format.dart';
import 'package:testable_web_app/order/forms/helpers/get_date_out_of_range_invalid_error_message.dart';
import 'package:testable_web_app/order/forms/helpers/validate_form_on_focus_out.dart';
import 'package:testable_web_app/order/forms/models/drug_dose_model.dart';
import 'package:testable_web_app/order/forms/models/order_form_input_model.dart';
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
    // - TODO: Replace with a clinic object with information details in case
    // we wish to display it

    // required this.clinic,
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
  final TextEditingController _productAutocompleteController =
      TextEditingController();
  final TextEditingController _productFreeTextController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _requiredDateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  /// More bespoke UX control required here
  /// Otherwise possible lite maintainable solution is a
  /// broad form FocusScopeTraversal and falling back on .next and nextFocus().
  ///
  /// Users appear to be heavily keyboard-driven/trained (pharmacy)
  ///
  /// Though we do market a modern app experience for ordering off mobile.
  final FocusNode _patientAutocompleteFocus = FocusNode();
  final FocusNode _productAutocompleteFocus = FocusNode();
  final FocusNode _productFreeTextFocus = FocusNode();

  final FocusNode _quantityFocusNode = FocusNode();
  final FocusNode _requiredDateFocusNode = FocusNode();
  final FocusNode _notesFocusNode = FocusNode();

  OrderFormInputModel _orderFormInputModel = OrderFormInputModel();

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
  PatientBaseInputModel? _selectedPatientOrAdHocCreated;

  /// Is new product for free text subform entry
  bool _isNewProductFreeText = false;

  /// Hide if free texting the product instead of selecting from the list.
  bool get _isProductSelectHidden => !_isNewProductFreeText;

  String? _adhocCreatedProductFreeText;

  ProductModel? _selectedProduct;

  bool get _isEveryDoseFieldHidden {
    return _selectedProduct != null || _isNewProductFreeText;
  }

  /// Drug doses should be initialised to allow access
  ///
  /// ! Dangerous array reference for child mutation
  /// Dart array not a sparse index
  List<double> _drugDoses = [];

  /// Reference the index from the drugDoses only.
  /// Access only up to _drugDoses.length
  ///
  /// ! Dangerous array reference for child mutation
  /// Hacky usability inclusion
  /// Multi drug is rare enough to be a minor use case
  ///
  /// Semi-hardcoded.
  /// Competitors only have up to two drugs
  ///
  /// We have duo and trio infusion dox vinc etop treatment products
  /// No use case for four or five combo; however, we can accommodate somewhat
  ///
  /// Perhaps a path in the future is to Scope the foci.
  ///
  /// However, this is adequate solution as parent context determines flow.
  ///
  /// Focus for next field flow.
  ///
  /// Dart only supports pass by reference.
  /// So we should pass in a function that takes index with a primed length
  /// limit
  ///
  /// the function will be regenerated on build (and we setState and rebuild
  /// on each time drugDoses array is changed
  /// )
  /// so this should be safe
  ///
  /// Should be disposed of
  final List<FocusNode> _drugDosesFocusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  /// Allow us to clear the text editing controllers used in child dose fields
  ///
  /// To enforce consistent UX and reduce edge behaviours
  /// i.e. Select product -> change first dose -> change product -> cached dose!
  final List<TextEditingController> _drugDosesTextEditingControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  // _show/hide

  @override
  void dispose() {
    _patientAutocompleteController.dispose();
    _productAutocompleteController.dispose();

    _patientAutocompleteFocus.dispose();
    _productAutocompleteFocus.dispose();

    // Dispose hard-coded dose field focus usability.
    _drugDosesFocusNodes.forEach(_disposeFocus);

    _drugDosesTextEditingControllers.forEach(_disposeTextController);

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

                    // Calling setState rebuild appears to
                    // close the autocomplete panel
                    _selectedPatientOrAdHocCreated = null;
                    _patientAutocompleteController.clear();
                  },
                  child: PatientAutocomplete<PatientModel>(
                    options: widget.patients,
                    focusNode: _patientAutocompleteFocus,
                    textEditingController: _patientAutocompleteController,
                    isTextFieldEnabled: _isPatientSelectHidden,
                    onSelected: (PatientModel option) {
                      // Do something
                      // Save

                      setState(() {
                        final PatientBaseInputModel selectedPatientDetail =
                            PatientBaseInputModel.fromPatientModel(
                          option,
                        );

                        _selectedPatientOrAdHocCreated = selectedPatientDetail;

                        _orderFormInputModel.patient = selectedPatientDetail;
                      });

                      // Focus Product field
                      _productAutocompleteFocus.requestFocus();
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // setState isNewPatient
                  setState(() {
                    _isNewPatientEntry = true;
                    _selectedPatientOrAdHocCreated = null;

                    _patientAutocompleteController.clear();
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
                    // - FIXME: OrderForm should have this clinic id
                    // or we should have it within the global app context
                    //
                    // As long as admin app is kept separate.
                    //
                    clinicIDToSave: 'PLACEHOLDER_STRING',
                    onSaveSuccess: (
                      PatientBaseInputModel? savedPatientDetails,
                    ) {
                      final bool unsuccessfulSave = savedPatientDetails == null;
                      if (unsuccessfulSave) {
                        return;
                      }
                      final PatientBaseInputModel successfulSavedPatient =
                          savedPatientDetails;

                      setState(() {
                        // Remove superfluous property. Replaced with InputModel
                        _selectedPatientOrAdHocCreated = successfulSavedPatient;

                        _orderFormInputModel.patient = successfulSavedPatient;
                      });

                      // Focus next node
                      _productAutocompleteFocus.requestFocus();
                    },
                  ),
                ),
              ),

              Container(
                padding: edgeInsetsFormFieldPadding,
                constraints: boxFieldWidthConstraintsLong,
                child: Focus(
                  onFocusChange: (bool focusedIn) {
                    final bool focusedOut = !focusedIn;
                    if (focusedOut) {
                      return;
                    }

                    // Do not call setState here as it force closes the panel?
                    _selectedProduct = null;
                    _productAutocompleteController.clear();
                  },
                  child: ProductAutocompleteField(
                    options: widget.products,
                    focusNode: _productAutocompleteFocus,
                    textEditingController: _productAutocompleteController,
                    isTextFieldEnabled: _isProductSelectHidden,

                    // - FIXME: Add onTap or other reset to clear.
                    onSelected: (ProductModel option) {
                      // Do something
                      // Save
                      setState(() {
                        _selectedProduct = option;
                        _adhocCreatedProductFreeText = null;

                        _orderFormInputModel.selectedProduct = option;

                        /// 1 Reset drug doses and 2 clear drug dose text fields

                        // Potential code smell. We could potentially
                        // leave it initialised with three elements
                        // as we probably will never see a five-drug product
                        //
                        // **Carefully manage this mutable referenceable state**
                        // We initialise this so that Flutter does not error
                        // out when it tries to access an index that does not
                        // exist in the array
                        // (The demo drug dose detail display)
                        _drugDoses = List.filled(
                          option.drugs.length,
                          0,
                        );

                        /// 2 Clear drug dose text fields for consistency.
                        _clearDrugDoseFieldsTextControllers();
                      });
                      // Focus next field
                      // the DoseFields should be built after the setState
                      // uncertain focus race conditions
                      //
                      // Focus the first dose field as it will be guaranteed
                      // (Product.drugs has minimum one drug)
                      _focusFirstDrugDoseField();
                    },
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedProduct = null;

                    _isNewProductFreeText = true;

                    _productAutocompleteController.clear();
                  });
                },
                child: const Text(
                  'Enter new product details',
                ),
              ),

              Visibility(
                visible: _isNewProductFreeText,
                child: IconButton(
                  icon: const Icon(Icons.undo),
                  onPressed: () {
                    setState(() {
                      // Reset toggle
                      _isNewProductFreeText = false;
                      _selectedProduct = null;

                      // No longer using the Product Autocomplete selection
                      _productAutocompleteController.clear();
                      // Resets both exclusive product inputs on null
                      _orderFormInputModel.selectedProduct = null;

                      // Reset subform
                      _adhocCreatedProductFreeText = null;
                    });
                  },
                ),
              ),

              Container(
                padding: edgeInsetsFormFieldPadding,
                width: 60,
                // - TODO: Replace with generated number of dose fields
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Product details',
                    helperText:
                        'Drugs - Dose (units), Container, Diluent, Volume',
                  ),
                  controller: _productFreeTextController,
                  focusNode: _productFreeTextFocus,
                  inputFormatters: [
                    // Rather than using maxLengthEnforcement
                    // which takes up space with a 0/6 char counter.
                    LengthLimitingTextInputFormatter(6),
                  ],
                  onFieldSubmitted: (String? quantityText) {
                    _checkSaveValidQuantityIntegerText(quantityText);
                    // Note blank tab focus bug found here
                    // an element is stealing focus between Qty and Req date

                    // Focus next field on submit (enter key on desktop)
                    _focusFirstDrugDoseField();
                  },
                  onSaved: (String? quantityText) {
                    _checkSaveValidQuantityIntegerText(quantityText);
                  },
                  // See submit focus for desktop behaviour without on-screen kb
                  textInputAction: TextInputAction.next,
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
                  drugs: _selectedProduct?.drugs ?? [],
                  baseFocusNodes: _drugDosesFocusNodes,
                  baseTextEditingControllers: _drugDosesTextEditingControllers,
                  onSubmitDrugDoseField: (
                    int drugIndexToSaveTo,
                    double dose,
                  ) {
                    // On valid entries only. Wary of trailing "."
                    // as invalid decimal text for [text] -> [double] conversion
                    setState(() {
                      _drugDoses[drugIndexToSaveTo] = dose;
                    });
                  },
                  onFinishedLastDoseFieldSubmitted: () {
                    _quantityFocusNode.requestFocus();
                  },
                  onSaveDrugDoseField: (
                    int drugIndexToSaveTo,
                    double dose,
                  ) {
                    // This seems fraught with issues

                    // Mutate parent array by reference?
                    setState(() {
                      _drugDoses[drugIndexToSaveTo] = dose;
                    });
                  },
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
                  controller: _quantityController,
                  focusNode: _quantityFocusNode,
                  inputFormatters: [
                    // Rather than using maxLengthEnforcement
                    // which takes up space with a 0/6 char counter.
                    LengthLimitingTextInputFormatter(6),
                  ],
                  onFieldSubmitted: (String? quantityText) {
                    _checkSaveValidQuantityIntegerText(quantityText);
                    // Note blank tab focus bug found here
                    // an element is stealing focus between Qty and Req date

                    // Focus next field on submit (enter key on desktop)
                    _requiredDateFocusNode.requestFocus();
                  },
                  onSaved: (String? quantityText) {
                    _checkSaveValidQuantityIntegerText(quantityText);
                  },
                  // See submit focus for desktop behaviour without on-screen kb
                  textInputAction: TextInputAction.next,
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
                    controller: _requiredDateController,
                    focusNode: _requiredDateFocusNode,
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
                    onTextSubmitted: (String? text) {
                      final bool isFieldValid =
                          _formKey.currentState?.validate() ?? false;

                      if (!isFieldValid) {
                        // Force refocus. Pressing enter defocuses desktop web.
                        _requiredDateFocusNode.requestFocus();
                        return;
                      }

                      _notesFocusNode.requestFocus();
                    },
                    onDateSaved: (DateTime date) {
                      // Potentially called with invalid text? on formState.save()
                      debugPrint('Valid date saved');
                      // Save to form model

                      setState(() {
                        _orderFormInputModel.requiredDate =
                            ausFullDateDisplayFormat.format(
                          date,
                        );
                      });
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
                controller: _notesController,
                focusNode: _notesFocusNode,
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

                onSaved: (String? notesText) {
                  if (notesText == null) {
                    // We do not use null here.
                    // Maybe somewhat dependent on data adaptor interpretation
                    //
                    _orderFormInputModel.notes = '';

                    return;
                  }

                  _orderFormInputModel.notes = notesText;
                },
                textInputAction: TextInputAction.done,
              ),

              ElevatedButton(
                onPressed: _saveForm,
                child: const Text(
                  'Add treatment product to order',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextButton(
                style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.padded,
                ),
                onPressed: _resetState,
                child: const Text(
                  'Reset form',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _focusFirstDrugDoseField() => _drugDosesFocusNodes[0].requestFocus();

  void _clearDrugDoseFieldsTextControllers() {
    _drugDosesTextEditingControllers.forEach(
      _clearTextEditingController,
    );
  }

  /// Declarative lint preference rather than in-line function literal
  void _clearTextEditingController(TextEditingController element) {
    element.clear();
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

  /// Declarative in the forEach drugDosesFocusNodes dispose
  /// Wrapper for code maintainibility (linter preference)
  ///
  void _disposeFocus(FocusNode focus) {
    focus.dispose();
  }

  /// Declarative wrapper for code maintainibility (linter preference)
  ///
  void _disposeTextController(TextEditingController focus) {
    focus.dispose();
  }

  /// The visual state of a fresh patient treatment order submission page
  void _resetState() {
    setState(() {
      _patientAutocompleteController.clear();
      _productAutocompleteController.clear();
      _quantityController.clear();
      _requiredDateController.clear();
      _notesController.clear();

      _isNewPatientEntry = false;
      _selectedPatientOrAdHocCreated = null;

      _isNewProductFreeText = false;
      _adhocCreatedProductFreeText = null;

      _selectedProduct = null;

      _orderFormInputModel = OrderFormInputModel();
    });
  }

  void _saveForm() {
    final bool isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid) {
      return;
    }
    _formKey.currentState?.save();

    // onSave handles the distinct fields;
    // however, we have additional logic around selection vs creation
    // which should be handled
    //
    // We manually transform the multi-dose array into our input save model

    final OrderFormInputModel localScopedFormModel = _orderFormInputModel;
    final ProductModel? selectedProduct = localScopedFormModel.selectedProduct;

    if (selectedProduct == null) {
      return;
    }
    localScopedFormModel.patient = _selectedPatientOrAdHocCreated;

    // - TODO: Change SelectedProduct to include adHocCreatedProduct
    // Now both should use the same base model

    // localScopedFormModel.drugDoses
    final List<DrugDose> drugDoses = _getDrugDosesFromDosesProduct(
      _drugDoses,
      selectedProduct,
    );

    localScopedFormModel.drugDoses = drugDoses;

    debugPrint(localScopedFormModel.toString());
  }

  List<DrugDose> _getDrugDosesFromDosesProduct(
    List<double> doses,
    ProductModel selectedProduct,
  ) {
    return doses.asMap().entries.map((entry) {
      final int index = entry.key;
      final double dose = entry.value;

      return DrugDose(
        drug: selectedProduct.drugs[index],
        dose: dose,
      );
    }).toList();
  }

  /// Saves to our progressive input model when valid
  ///
  /// Either on field submit or form submit (mandatory)
  ///
  ///
  void _checkSaveValidQuantityIntegerText(
    String? quantityText,
  ) {
    if (quantityText == null || quantityText.isEmpty) {
      _orderFormInputModel.quantity = null;

      return;
    }

    final int? quantity = int.tryParse(quantityText);
    if (quantity == null) {
      _orderFormInputModel.quantity = null;
      return;
    }

    setState(() {
      _orderFormInputModel.quantity = quantity;
    });
  }
}
