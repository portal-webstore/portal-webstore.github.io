import 'package:testable_web_app/webstore/catalogue/product/models/drug_model.dart'
    show DrugModel;

/// Get informative drug displayable text
///
/// e.g. Pembrolizumab (mg)
String getDrugViewModel(DrugModel drug) {
  final String drugText = '${drug.drugName} (${drug.drugUnits})';

  return drugText;
}
