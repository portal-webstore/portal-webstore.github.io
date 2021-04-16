import 'package:flutter/material.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart'
    show ProductModel;

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    Key? key,
    required this.productData,
    required this.onTap,
  }) : super(key: key);

  final ProductModel productData;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _header(),
        ],
      ),
    );
  }

  /// Minimal issue using functional return widget as we expect the whole
  /// detail to be loaded at once
  ///
  /// Loses const though.
  Widget _header() {
    const int titleFirstLineMax = 1;
    const int subtitleSecondThirdLineMax = 2;

    return ListTile(
      leading: const Icon(Icons.science),
      title: Text(
        productData.productName,
        maxLines: titleFirstLineMax,
      ),
      subtitle: Text(
        getSubtitleContentLines(productData),
        maxLines: subtitleSecondThirdLineMax,
      ),
      isThreeLine: true,
    );
  }

  /// The second and third line is provided by subtitle body
  /// when isThreeLine is enabled
  String getSubtitleContentLines(ProductModel data) {
    const String newLine = '\n';

    return getDrugsListProductViewModel(productData) +
        newLine +
        getContainerProductDetailViewModel(productData);
  }

  String getDrugsListProductViewModel(ProductModel data) {
    final String prefix = data.drugs.length > 1 ? 'Drugs' : 'Drug';
    final String drugsListLine =
        '$prefix: ${data.getDrugsListCommaSeparatedText()}';

    return drugsListLine;
  }

  String getContainerProductDetailViewModel(ProductModel data) {
    const String prefix = 'Container: ';
    final String containerListLine = '$prefix: ${data.containerName}';

    return containerListLine;
  }
}
