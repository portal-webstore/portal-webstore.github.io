import 'package:equatable/equatable.dart';

class PatientModel extends Equatable {
  const PatientModel({
    required this.patientID,
    required this.patientFirstName,
    required this.patientLastName,
    required this.patientHealthcareRecordNumber,
    required this.patientBirthDate,
  });

  final String patientID;
  final String patientFirstName;
  final String patientLastName;

  /// MRN URN
  final String patientHealthcareRecordNumber;

  /// Danger format
  final String patientBirthDate;

  @override
  List<Object> get props => [
        patientID,
        patientFirstName,
        patientLastName,
        patientHealthcareRecordNumber,
        patientBirthDate,
      ];
}
