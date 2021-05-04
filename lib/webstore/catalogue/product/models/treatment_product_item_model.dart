import 'package:equatable/equatable.dart' show Equatable;
import 'package:testable_web_app/order/forms/models/drug_dose_model.dart'
    show DrugDose;

/// This represents the item that is saved to the order
/// Rather than the selected product
///
/// Also note that model converges in the ad hoc free-text creation where
/// the dose is entered in as well
///
/// Free-form more closely resemble the minimum subset of fields required to
/// generate an order card with the text information displayable for
/// reprocessing
class TreatmentProductItemModel extends Equatable {
  const TreatmentProductItemModel({
    required this.productName,
    required this.diluentName,
    required this.containerName,
    required this.drugDoses,
    required this.productAdministrationRoute,
    required this.isOnHold,
  });

  /// Product name concatenates up the diluent container parts.
  final String productName;

  /// Null where not valid to have diluent name (e.g. OCS)
  /// Empty string to indicate given as empty
  final String? diluentName;

  /// All current cases should have a containerName
  final String? containerName;

  final List<DrugDose> drugDoses;

  /// ITHEC IVINF IVENOS
  final String productAdministrationRoute;

  final bool isOnHold;

  @override
  List<Object> get props => [
        productName,
        diluentName ?? '',
        containerName ?? '',
        drugDoses,
        productAdministrationRoute,
      ];
}
