import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testable_web_app/i18n/date/australia_date_locale_format.dart';
import 'package:testable_web_app/order/forms/helpers/get_date_out_of_range_invalid_error_message.dart';
import 'package:testable_web_app/order/forms/helpers/validate_form_on_focus_out.dart';
import 'package:testable_web_app/patient/models/patient_model.dart'
    show PartialPatientInputModel, PatientBaseInputModel, PatientModel;
import 'package:testable_web_app/shared/forms/helpers/formatters/uppercase_text_formatter.dart';

class CreatePatientForm extends StatefulWidget {
  const CreatePatientForm({
    Key? key,
    required this.formKey,
    required this.onSaveSuccess,
    required this.clinicIDToSave,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  final String clinicIDToSave;

  /// Optional to allow ux feedback flexibility rather than
  /// only running when completely successful non-null?
  ///
  /// Rename this?
  final void Function(PatientBaseInputModel?) onSaveSuccess;
  @override
  _CreatePatientFormState createState() => _CreatePatientFormState();
}

class _CreatePatientFormState extends State<CreatePatientForm> {
  final TextEditingController _recordNumberController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _dobTextController = TextEditingController();

  static const String _dateFormatErrorMessage =
      'Please enter (dd/MM/yyyy) format';
  static const Duration _veryOldYears = Duration(
    days: 365 * 123,
  );
  final DateTime _currentDateTime = DateTime.now();

  final _veryOldMinimumStartBirthDate = DateTime.now().subtract(
    // 123 years old?
    _veryOldYears,
  );

  /// Reset by creating a new blank object.
  PartialPatientInputModel _savedPatientInputFormModel =
      PartialPatientInputModel();

  /// Lock on successful save
  bool _isSavedFormLocked = false;
  bool get _isFormEnabled => !_isSavedFormLocked;

  @override
  void dispose() {
    _dobTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          Row(
            children: [
              SizedBox(
                width: 120,
                height: 80,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Record number',
                    helperText: '(URN/MRN)',
                  ),
                  enabled: _isFormEnabled,
                  controller: _recordNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (String? input) {
                    if (input == null) {
                      return null;
                    }

                    // Google code base follows paradigm of
                    // evaluating all the errors to messages first
                    // and falling back to null success/ignore at final point
                    if (input.isEmpty) {
                      return 'Please enter number';
                    }

                    return null;
                  },
                  onSaved: (String? text) {
                    if (text == null) {
                      // Assign null for required inputs.
                      setState(() {
                        _savedPatientInputFormModel
                            .patientHealthcareRecordNumber = null;
                      });
                      return;
                    }
                    if (text.isEmpty) {
                      setState(() {
                        _savedPatientInputFormModel
                            .patientHealthcareRecordNumber = null;
                      });
                    }

                    setState(() {
                      _savedPatientInputFormModel
                          .patientHealthcareRecordNumber = text;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 160,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'LAST name',
                    helperText: '',
                  ),
                  enabled: _isFormEnabled,
                  controller: _lastNameController,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (String? input) {
                    if (input == null) {
                      return null;
                    }
                    if (input.isEmpty) {
                      return 'Please enter NAME';
                    }

                    return null;
                  },
                  onSaved: (String? text) {
                    if (text == null) {
                      // Assign null for required inputs.
                      setState(() {
                        _savedPatientInputFormModel.patientLastName = null;
                      });
                      return;
                    }
                    if (text.isEmpty) {
                      setState(() {
                        _savedPatientInputFormModel.patientLastName = null;
                      });
                    }

                    setState(() {
                      _savedPatientInputFormModel.patientLastName = text;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 180,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'First name',
                    helperText: '',
                  ),
                  enabled: _isFormEnabled,
                  controller: _firstNameController,
                  validator: (String? input) {
                    if (input == null) {
                      return null;
                    }
                    if (input.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                  onSaved: (String? text) {
                    if (text == null) {
                      // Assign null for required inputs.
                      setState(() {
                        _savedPatientInputFormModel.patientFirstName = null;
                      });
                      return;
                    }
                    if (text.isEmpty) {
                      setState(() {
                        _savedPatientInputFormModel.patientFirstName = null;
                      });
                    }

                    setState(() {
                      _savedPatientInputFormModel.patientFirstName = text;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                width: 120,
                child: Focus(
                  onFocusChange: (bool isFocusedIn) => validateFormOnFocusOut(
                    isFocusedIn: isFocusedIn,
                    formKey: widget.formKey,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Date of birth',
                      helperText: 'dd/MM/yyyy',
                    ),
                    enabled: _isFormEnabled,
                    controller: _dobTextController,
                    keyboardType: TextInputType.datetime,
                    validator: (String? text) {
                      if (text == null) {
                        return MaterialLocalizations.of(context)
                            .invalidDateFormatLabel;
                      }

                      return _validateDateText(text);
                    },
                    onSaved: (String? text) {
                      if (text == null) {
                        // Assign null for required inputs.
                        setState(() {
                          _savedPatientInputFormModel.patientBirthDate = null;
                        });
                        return;
                      }
                      if (text.isEmpty) {
                        setState(() {
                          _savedPatientInputFormModel.patientBirthDate = null;
                        });
                      }

                      final String? errorInvalidMessage =
                          _validateDateText(text);
                      final bool isValidDateText = errorInvalidMessage == null;
                      final bool isInvalidDateTextErrored = !isValidDateText;

                      final DateTime? parsedDate = _parseDate(text);
                      final bool isUnparsableDate = parsedDate == null;

                      if (isInvalidDateTextErrored || isUnparsableDate) {
                        // This should not have been possible
                        _savedPatientInputFormModel.patientBirthDate = null;

                        return;
                      }

                      setState(() {
                        _savedPatientInputFormModel.patientBirthDate = text;
                      });
                    },
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  _setTextControllerFromDatePicked(context);
                },
              ),
            ],
          ),
          Row(
            children: [
              TextButton.icon(
                onPressed: _isSavedFormLocked ? null : _saveFields,
                icon: const Icon(Icons.save_alt_outlined),
                label: const Text('Save fields'),
              ),
              const SizedBox(
                width: 8.0,
              ),
              TextButton.icon(
                onPressed: _isSavedFormLocked ? _unlockForm : _resetForm,
                icon: const Icon(Icons.undo_sharp),
                label: _isSavedFormLocked
                    ? const Text('Unlock')
                    : const Text('Reset'),
              )
            ],
          )
        ],
      ),
    );
  }

  /// Allow unlocking form first
  ///
  /// 1. If form is locked, allow unlocking form.
  /// 2. If form is already unlocked, allow resetting form.
  ///
  /// Map events to states
  void _unlockForm() {
    /// Ideally allow unlocking the form the first time pressed
    /// and then allow resetting when the form is unlocked.
    ///
    /// Rather than resetting everything after a save
    /// in case a user wants to edit one specific field backtracked
    /// without needing to enter free-text new patient info in all fields again.
    setState(() {
      _isSavedFormLocked = false;
    });
  }

  void _resetForm() {
    setState(() {
      _isSavedFormLocked = false;
      _resetTextFields();
      _resetSavedPatientInputs();
    });
  }

  /// Attempts to save the given patient fields into a patient
  /// with the given clinic ID
  ///
  void _saveFields() {
    // Validate

    // Validate near end on button and date
    // to check for errors and defer big red alert messages
    // when partial early text is being filled in.
    //

    final bool isValidForm = widget.formKey.currentState?.validate() ?? false;

    final bool isInvalidForm = !isValidForm;

    // Check progressive model;

    if (isInvalidForm) {
      widget.onSaveSuccess(null);

      return;
    }

    widget.formKey.currentState?.save();

    // - FIXME: Replace these placeholders
    final PartialPatientInputModel savedPatient = _savedPatientInputFormModel;

    final bool isInvalidPatientInput = savedPatient.invalid;
    if (isInvalidPatientInput) {
      widget.onSaveSuccess(null);

      return;
    }

    try {
      final PatientBaseInputModel validPatientInput = PatientBaseInputModel(
        patientFirstName: savedPatient.patientFirstName!,
        patientLastName: savedPatient.patientLastName!,
        patientHealthcareRecordNumber:
            savedPatient.patientHealthcareRecordNumber!,
        patientBirthDate: savedPatient.patientBirthDate!,
        clinicID: widget.clinicIDToSave,
      );

      _isSavedFormLocked = true;
      widget.onSaveSuccess(validPatientInput);

      return;
    } on Exception catch (exc) {
      //
      debugPrint(
        'Error saving patient fields',
      );
      return;
    }
  }

  void _resetTextFields() {
    setState(() {
      _recordNumberController.clear();
      _lastNameController.clear();
      _firstNameController.clear();
      _dobTextController.clear();
    });

    return;
  }

  void _resetState() {
    setState(() {
      _isSavedFormLocked = false;
      _resetSavedPatientInputs();
    });

    return;
  }

  void _resetSavedPatientInputs() {
    _savedPatientInputFormModel = PartialPatientInputModel();
  }

  Future<void> _setTextControllerFromDatePicked(
    BuildContext context,
  ) async {
    // Slightly redundant though good to reuse the date fns
    final DateTime? date = await showDatePicker(
      context: context,
      // We could probably hard-code an average age of 60 to 80 for initial view
      // Though input mode makes the calendar view redundant.
      initialDate: _currentDateTime,
      firstDate: _veryOldMinimumStartBirthDate,
      lastDate: _currentDateTime,
      initialEntryMode: DatePickerEntryMode.input,
    );

    if (date == null) {
      return;
    }

    // For user feedback on completing the picking or input via calendar widget
    final String dateTimeText = ausFullDateDisplayFormat.format(date);

    _dobTextController.text = dateTimeText;
    final bool? isValid = widget.formKey.currentState?.validate();

    if (isValid == null || !isValid) {
      return;
    }
    // Assuming setState is redundant rebuilt via form state validate trigger
    // setState(() {
    //   //
    // });
  }

  // REFACTOR ME:
  //
  String? _validateDateText(String? text) {
    final DateTime? date = _parseDate(text);

    if (date == null) {
      return _dateFormatErrorMessage;
      // ?? MaterialLocalizations.of(context).invalidDateFormatLabel;
    }

    final String? validateDateFormatRangeErrorMessage = _validateDate(date);
    if (validateDateFormatRangeErrorMessage != null) {
      return validateDateFormatRangeErrorMessage;
    }

    return null;
  }

  DateTime? _parseDate(String? text) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return localizations.parseCompactDate(text);
  }

  String? _validateDate(DateTime date) {
    if (!_isDateWithinRange(date)) {
      return getDateOutOfRangeInvalidErrorMessage(
        _veryOldMinimumStartBirthDate,
        _currentDateTime,
      );
    }
    return null;
  }

  bool _isDateWithinRange(DateTime? date) {
    return date != null &&
        !date.isBefore(_veryOldMinimumStartBirthDate) &&
        !date.isAfter(_currentDateTime);
  }
}
