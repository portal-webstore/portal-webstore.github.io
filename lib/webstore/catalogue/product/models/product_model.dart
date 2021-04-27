import 'package:equatable/equatable.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/drug_model.dart';

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
