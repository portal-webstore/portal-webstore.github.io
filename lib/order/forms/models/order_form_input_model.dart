import 'package:testable_web_app/order/forms/models/drug_dose_model.dart'
    show DrugDose;
import 'package:testable_web_app/patient/models/patient_model.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/drug_model.dart'
    show DrugModel;
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';

class OrderFormInputModel {
  PatientBaseInputModel? patient;

  /// Product selection and product free text are mutually exclusive
  ProductModel? _selectedProduct;

  /// Product selection and product free text are mutually exclusive
  String? _freeTextedProduct;

  int? quantity;

  /// Should be translated into a standard yyyy-MM-dd for database consistency
  ///
  String? requiredDate;

  /// Note blank empty string means given as blank (when field is submitted
  /// as part of the form, although notes is unused)
  ///
  /// Rather than null meaning it is yet to be given or not given
  ///
  String notes = '';

  /// Pre-transformed utility for colocated access of both the drug
  /// with its respective dose
  ///
  /// For easier data saving next step.
  List<DrugDose>? drugDoses;

  bool get isProductSelected => _freeTextedProduct != null;

  /// Product selection and product free text are mutually exclusive
  ///
  /// May end up superfluous when we add in the product creation model
  ///
  bool get isProductFreeTexted => _freeTextedProduct != null;

  bool get isProductInputValid => !isProductSelectionCreationInputInvalid;

  /// One and only one should be non-null to be valid.
  /// Product selection and product free text are mutually exclusive
  bool get isProductSelectionCreationInputInvalid {
    // Are both fields entered somehow.
    // Dart spec does not allow xor.
    // 0110 xor check these nulls.

    final bool isBothInput =
        _selectedProduct != null && _freeTextedProduct != null;
    final bool isBothNotInput =
        _selectedProduct == null && _freeTextedProduct == null;

    return isBothInput || isBothNotInput;
  }

  bool get _isQuantityValid => quantity != null && quantity! > 0;

  bool get _isDoseFoundForEachProductDrugForSelectedProduct {
    final List<DrugDose>? doses = drugDoses;
    final List<DrugModel>? selectedProductDrugs = _selectedProduct?.drugs;

    if (doses == null || selectedProductDrugs == null) {
      return false;
    }

    return doses.length == selectedProductDrugs.length;
  }

  ProductModel? get selectedProduct {
    return _selectedProduct;
  }

  /// No type unions - could use dynamic

  /// Control setters
  ///
  /// Do not expect null
  ///
  /// Nullifies the free text as soon as we select a product.
  ///
  /// To maintain consistency
  /// Product selection and product free text are mutually exclusive
  /// until we create ad hoc product information with more fields
  set selectedProduct(ProductModel? selectedProduct) {
    _freeTextedProduct = null;

    if (selectedProduct == null) {
      _selectedProduct = null;
      return;
    }

    _selectedProduct = selectedProduct;
  }

  String? get freeTextedCreatedProduct {
    return _freeTextedProduct;
  }

  /// Nullifies the selected product as soon as we attempt to input free text.
  ///
  /// To maintain consistency
  /// Product selection and product free text are mutually exclusive
  set freeTextedCreatedProduct(String? freeTextedProduct) {
    _selectedProduct = null;

    if (freeTextedCreatedProduct == null) {
      _freeTextedProduct = null;
      return;
    }

    _freeTextedProduct = freeTextedProduct;
  }

  bool isValid() {
    final bool isQuantityValid = _isQuantityValid;

    // No redundant double check on date range, format submission?
    // localizations.parseCompactDate(text)
    final isRequiredDateValid = requiredDate != null;

    final bool isAllowedFreeTextNoDoseOrSelectedDrugWithDoses =
        _isAllowedNoDoseFreeTextProductOrSelectedProductDrugsWithDoses;

    return patient != null &&
        isProductInputValid &&
        isAllowedFreeTextNoDoseOrSelectedDrugWithDoses &&
        isQuantityValid &&
        isRequiredDateValid;
  }

  ///
  /// Should not have both a free text product and multi doses.
  bool get _isAllowedNoDoseFreeTextProductOrSelectedProductDrugsWithDoses {
    // OR would fulfill most of our cases
    // We should XOR if we want to be really explicit that they could not both
    // be true according to business rules.

    return isProductFreeTexted ||
        _isDoseFoundForEachProductDrugForSelectedProduct;
  }
}
