import 'package:testable_web_app/webstore/catalogue/product/models/drug_model.dart';

class DrugDose {
  const DrugDose({
    required this.drug,
    required this.dose,
  });

  final DrugModel drug;

  final double dose;
}
