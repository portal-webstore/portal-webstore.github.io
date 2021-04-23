import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;

/// Some inspirations from future-thinking OCS routine one-way update
/// made it here
class PatientModel extends Equatable {
  const PatientModel({
    required this.patientID,
    required this.patientFirstName,
    required this.patientLastName,
    required this.patientHealthcareRecordNumber,
    required this.patientBirthDate,
    required this.clinicID,
    required this.patientLastUpdatedAt,
    required this.ocsPatientLink,
    required this.ocsLastUpdatedAt,
  });

  final String patientID;
  final String patientFirstName;
  final String patientLastName;

  /// MRN URN
  final String patientHealthcareRecordNumber;

  /// Danger format
  final String patientBirthDate;

  /// Present here for simplicity. Not necessary for retrieval if covered by query.
  final String clinicID;

  /// e.g. the routine overnight upload timestamp?
  ///
  /// Leaving as String until we determine physical implementation middleware db
  ///
  final String patientLastUpdatedAt;

  /// For use case of OCS source of truth scraped overnight to fill the
  /// onc webstore ordering portal dropdowns per clinic
  ///
  final int ocsPatientLink;

  /// Standard flexibility convention seems to use string form of an ISO 8601
  /// sortable/filterable
  /// i.e. 0001-01-01T00:00:00Z
  /// 2021-01-01T10:00:00.000Z
  /// is it still string fileratble
  /// otherwise use unix epochs up to milliseconds
  /// firebase goes up to nanoseconds - wonder if still stirng filterable if
  /// Z is optional vs a digit char.
  /// 00.000000000Z
  /// 00.000000Z
  /// 00.000Z
  ///
  ///
  final String ocsLastUpdatedAt;

  @override
  List<Object> get props => [
        patientID,
        patientFirstName,
        patientLastName,
        patientHealthcareRecordNumber,
        patientBirthDate,
        clinicID,
        patientLastUpdatedAt,
        ocsPatientLink,
        ocsLastUpdatedAt,
      ];
}

/// Constant class to save us from having to revalidate parts
///
/// - TODO: Should probably abstract the base patient properties later for reuse
/// in the data model and the partial input models
///
/// Concreting here due to uncertainty of support for Equatable, multi inheri
/// super implementations, abstract or mixin workarounds
///
///
@immutable
class PatientInputModel {
  const PatientInputModel({
    required this.patientFirstName,
    required this.patientLastName,
    required this.patientHealthcareRecordNumber,
    required this.patientBirthDate,
    required this.clinicID,
  });
  final String patientFirstName;
  final String patientLastName;

  /// MRN URN
  final String patientHealthcareRecordNumber;

  /// Danger format
  final String patientBirthDate;

  final String clinicID;
}

/// Form input model
///
/// Similar to TypeScript concept of Partial<Model> to optionalise properties
class PartialPatientInputModel {
  PartialPatientInputModel({
    this.patientFirstName,
    this.patientLastName,
    this.patientHealthcareRecordNumber,
    this.patientBirthDate,
  });

  /// Can potentially generate UUID;
  /// DynamoDBAutoGeneratedKey  ?
  /* String? patientID; */

  String? patientFirstName;
  String? patientLastName;

  /// MRN URN
  String? patientHealthcareRecordNumber;

  /// Danger format
  String? patientBirthDate;

  /// Saving here for simplicity?
  /// May not be used
  String? clinicID;

  bool get valid => !invalid;
  bool get invalid => _isInvalid();

  /// Helper to check all the inputs are given
  ///
  /// e.g. to use in a new model
  bool _isInvalid() {
    return patientFirstName == null ||
            patientLastName == null ||
            patientHealthcareRecordNumber == null ||
            patientBirthDate == null
        // Omitting clinicID here as we may add that on later.
        ;
  }
}
