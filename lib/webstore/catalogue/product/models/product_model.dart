import 'package:equatable/equatable.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/drug_model.dart';

/// The divergence of the product models is likely going to be a source of bugs
/// in the future
///
/// Add base product model reference
/// Add ad hoc "created" semi-structured free-text product model that may be
/// assisted through hard-coded dropdowns
class BaseProductModel extends Equatable {
  const BaseProductModel({
    required this.productName,
    required this.diluentName,
    required this.containerName,
    required this.drugs,
    required this.productAdministrationRoute,
  });

  /// Simplified model has drugs and container name (diluent/type)
  final String productName;

  /// Null where not valid to have diluent name (e.g. OCS)
  /// Empty string to indicate given as empty
  final String? diluentName;

  final String? containerName;

  /// Free-text drug name and
  /// Free-text drug units of measure
  final List<DrugModel> drugs;

  /// ITHEC IVINF IVENOS
  final String productAdministrationRoute;

  @override
  List<Object> get props => [
        productName,
        diluentName ?? '',
        containerName ?? '',
        drugs,
        productAdministrationRoute,
      ];
}

/// Simplified view model of the product data required to display and
/// submit an order for this specific product
///
///
class ProductModel extends Equatable {
  const ProductModel({
    required this.productID,
    required this.productName,
    required this.containerName,
    required this.drugs,
    required this.productAdministrationRoute,
    required this.ocsProductID,
  });

  /// For potential ease of INSERT
  /// UUID
  final String productID;

  /// Simplified model has drugs and container name (diluent/type)
  final String productName;

  /// May be redundant if we simplify to only use the flat product name.
  ///
  /// Helps if we definitely want the container part pre-separated on order
  /// Otherwise superfluous as product name already has container name in it..
  ///
  /// May also be the conjoined containerVariantName + containerBaseName
  /// for surefusers
  final String containerName;

  /// Required for per-drug dose input fields with given units
  /// Expect input in the predefined OCS units.
  /// No unit conversion on customer input.
  final List<DrugModel> drugs;

  /// Administration route
  /// common route variations with syringes for the same drug ITHEC IVINF IVENOS
  ///
  final String productAdministrationRoute;

  /// To link back.
  /// Not required for display.
  /// Could be kept entirely out of this interface.
  /// For future reintegration
  ///
  /// May not even be required in the internal history view
  /// as manually reprocessed.
  final int ocsProductID;

  /// Note that this display may not be required for a single customer
  // final double maximumVolume;
  // final String dongle;

  // final double price;
  // final String imageAssetPath;

  @override
  List<Object> get props => [
        productID,
        productName,
        containerName,
        drugs,
        productAdministrationRoute,
        ocsProductID
      ];

  String getDrugsListCommaSeparatedText() {
    return drugs.join(', ');
  }
}

String productViewModelDrugs(List<DrugModel> drugs) {
  return drugs.join(', ');
}
