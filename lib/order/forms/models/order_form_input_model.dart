import 'package:testable_web_app/patient/models/patient_model.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';

class OrderFormInputModel {
  PatientBaseInputModel? patient;

  /// Product selection and product free text are mutually exclusive
  ProductModel? _selectedProduct;

  /// Product selection and product free text are mutually exclusive
  String? _freeTextedProduct;

  int? quantity;

  String? requiredDate;

  String? notes;

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

  /// Control setters
  ///
  /// Nullifies the free text as soon as we select a product.
  ///
  /// To maintain consistency
  /// Product selection and product free text are mutually exclusive
  void inputProduct(ProductModel selectedProduct) {}

  /// Nullifies the selected product as soon as we attempt to input free text.
  ///
  /// To maintain consistency
  /// Product selection and product free text are mutually exclusive
  void inputCreateProductFreeText(String freeTextedProduct) {
    // Needs dose and units as well in here.
    //
  }

  /// No type unions - could use dynamic

  ProductModel? getSelectedProduct() {
    return _selectedProduct;
  }

  String? getFreeTextedProduct() {
    return _freeTextedProduct;
  }

  bool isValid() {
    final bool isQuantityValid = quantity != null && quantity! > 0;

    // No redundant double check on date range, format submission?
    // localizations.parseCompactDate(text)
    final isRequiredDateValid = requiredDate != null;

    return patient != null &&
        isProductInputValid &&
        isQuantityValid &&
        isRequiredDateValid;
  }
}
