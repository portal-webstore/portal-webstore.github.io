import 'package:testable_web_app/patient/models/patient_model.dart';

String getPatientViewModel(PatientModel patient) {
  final String lastNameUpperCased = patient.patientLastName.toUpperCase();
  final String firstName = patient.patientFirstName;
  final String dob = patient.patientBirthDate;
  final String healthcareRecordNumber = patient.patientHealthcareRecordNumber;

  final String formattedName = '$lastNameUpperCased, $firstName';
  final String formattedDob = '($dob)';

  return '$formattedName; '
      '$formattedDob; '
      '$healthcareRecordNumber';
}
