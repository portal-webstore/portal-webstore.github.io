import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';

/// Separating this out from the prototype product model
/// in case we want to rely more heavily on generated graphql types in the future
///
/// Slightly more maintainable in a separate implementation.
///
/// GraphQL generation with schemae tooling may get convoluted with repository
/// sub packages (Clean code dart-only, testable units)
String getProductViewModel(
  ProductModel product,
) {
  // Expect simplified product name to already include container and drugs info
  // Route required.
  return '${product.productName}; '
      '${product.productAdministrationRoute}';
}
