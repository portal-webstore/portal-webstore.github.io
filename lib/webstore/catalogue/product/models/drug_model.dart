import 'package:equatable/equatable.dart' show Equatable;
import 'package:testable_web_app/webstore/catalogue/product/models/get_drug_viewmodel.dart'
    show getDrugViewModel;

class DrugModel extends Equatable {
  const DrugModel({
    required this.drugID,
    required this.drugName,
    required this.drugUnits,
    required this.ocsDrugID,
  });

  final String drugID;
  final String drugName;
  final String drugUnits;
  final int ocsDrugID;

  @override
  List<Object> get props => [
        drugID,
        drugName,
        drugUnits,
        ocsDrugID,
      ];

  @override
  String toString() {
    return getDrugViewModel(this);
  }
}
