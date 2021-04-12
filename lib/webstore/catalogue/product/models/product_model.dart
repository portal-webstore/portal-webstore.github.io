import 'package:equatable/equatable.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/drug_model.dart';

/// Simplified view model of the product data required to display and
/// submit an order for this specific product
///
///
class ProductModel extends Equatable {
  const ProductModel(
    this.productID,
    this.productName,
    this.containerName,
    this.drugs,
  );

  final int productID;

  final String productName;
  final String containerName;
  final List<DrugModel> drugs;

  /// Note that this display may not be required for a single customer
  // final double maximumVolume;
  // final String drugAdministrationRoute;
  // final String dongle;

  // final double price;
  // final String imageAssetPath;

  @override
  List<Object> get props => [
        productID,
        productName,
        containerName,
        drugs,
      ];

  String getDrugsListCommaSeparatedText() {
    return drugs.join(',');
  }
}

String productViewModelDrugs(List<DrugModel> drugs) {
  return drugs.join(',');
}