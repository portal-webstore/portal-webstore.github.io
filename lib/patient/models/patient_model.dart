class PatientModel {
  const PatientModel(
    this.patientID,
    this.patientFirstName,
    this.patientLastName,
    this.patientHealthcareRecordNumber,
    this.patientBirthDate,
  );

  final String patientID;
  final String patientFirstName;
  final String patientLastName;

  /// MRN URN
  final String patientHealthcareRecordNumber;
  final String patientBirthDate;
}
