import 'package:equatable/equatable.dart';

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
}
