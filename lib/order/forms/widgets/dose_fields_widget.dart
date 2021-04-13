import 'package:flutter/material.dart';
import 'package:testable_web_app/order/forms/widgets/dose_field_widget.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/drug_model.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';

class DrugDoseFields extends StatelessWidget {
  const DrugDoseFields({
    Key? key,
    required this.drugs,
  }) : super(key: key);

  final List<DrugModel> drugs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        drugs.length,
        (int index) {
          final DrugModel drug = drugs[index];

          return DoseField(
            drug: drug,
          );
        },
      ),
    );
  }
}

int getNumberOfDrugDoseFieldsFromProduct(ProductModel? product) {
  if (product == null) {
    return 0;
  }

  return product.drugs.length;
}
