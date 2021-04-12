import 'package:equatable/equatable.dart';

class DrugModel extends Equatable {
  const DrugModel(
    this.drugName,
    this.drugUnits,
  );

  final String drugName;
  final String drugUnits;

  @override
  List<Object> get props => [
        drugName,
        drugUnits,
      ];
}
