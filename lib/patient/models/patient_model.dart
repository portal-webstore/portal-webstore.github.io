import 'package:equatable/equatable.dart';

class PatientModel extends Equatable {
  const PatientModel({
    required this.patientID,
    required this.patientFirstName,
    required this.patientLastName,
    required this.patientHealthcareRecordNumber,
    required this.patientBirthDate,
    required this.ocsPatientLink,
    required this.clinicID,
  });

  final String patientID;
  final String patientFirstName;
  final String patientLastName;

  /// MRN URN
  final String patientHealthcareRecordNumber;

  /// Danger format
  final String patientBirthDate;

  /// For use case of OCS source of truth scraped overnight to fill the
  /// onc webstore ordering portal dropdowns per clinic
  ///
  final int ocsPatientLink;

  /// Present here for simplicity. Not necessary for retrieval if covered by query.
  final String clinicID;

  @override
  List<Object> get props => [
        patientID,
        patientFirstName,
        patientLastName,
        patientHealthcareRecordNumber,
        patientBirthDate,
      ];
}
