import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testable_web_app/i18n/date/australia_date_locale_format.dart';
import 'package:testable_web_app/order/forms/helpers/get_date_out_of_range_invalid_error_message.dart';
import 'package:testable_web_app/order/forms/helpers/validate_form_on_focus_out.dart';
import 'package:testable_web_app/patient/models/patient_model.dart'
    show PatientModel;
import 'package:testable_web_app/shared/forms/helpers/formatters/uppercase_text_formatter.dart';

class CreatePatientForm extends StatefulWidget {
  const CreatePatientForm({
    Key? key,
    required this.formKey,
    required this.onSaveSuccess,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  /// Optional to allow ux feedback flexibility rather than
  /// only running when completely successful non-null?
  ///
  /// Rename this?
  final void Function(PatientModel?) onSaveSuccess;
  @override
  _CreatePatientFormState createState() => _CreatePatientFormState();
}

class _CreatePatientFormState extends State<CreatePatientForm> {
  final TextEditingController dobTextController = TextEditingController();

  static const String dateFormatErrorMessage =
      'Please enter (dd/MM/yyyy) format';
  static const Duration veryOldYears = Duration(
    days: 365 * 123,
  );
  final DateTime currentDateTime = DateTime.now();

  final veryOldMinimumStartBirthDate = DateTime.now().subtract(
    // 123 years old?
    veryOldYears,
  );

  @override
  void dispose() {
    dobTextController.dispose();

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
                    //
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
                    //
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
                    //
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
                    controller: dobTextController,
                    keyboardType: TextInputType.datetime,
                    validator: (String? text) {
                      if (text == null) {
                        return MaterialLocalizations.of(context)
                            .invalidDateFormatLabel;
                      }

                      return _validateDateText(text);
                    },
                    onSaved: (String? text) {
                      //
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
                onPressed: () {
                  // Validate

                  // Validate near end on button and date
                  // to check for errors and defer big red alert messages
                  // when partial early text is being filled in.
                  //

                  final bool isValidForm =
                      widget.formKey.currentState?.validate() ?? false;

                  final bool isInvalidForm = !isValidForm;

                  // Check progressive model;

                  if (isInvalidForm) {
                    widget.onSaveSuccess(null);

                    return;
                  }

                  // - FIXME: Replace these placeholders
                  final PatientModel? validatedPatient = null;
                  final isInvalidPatientInput = true;

                  if (isInvalidPatientInput) {
                    widget.onSaveSuccess(null);

                    return;
                  }

                  widget.onSaveSuccess(validatedPatient);
                },
                icon: const Icon(Icons.save_alt_outlined),
                label: const Text('Save fields'),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> _setTextControllerFromDatePicked(
    BuildContext context,
  ) async {
    // Slightly redundant though good to reuse the date fns
    final DateTime? date = await showDatePicker(
      context: context,
      // We could probably hard-code an average age of 60 to 80 for initial view
      // Though input mode makes the calendar view redundant.
      initialDate: currentDateTime,
      firstDate: veryOldMinimumStartBirthDate,
      lastDate: currentDateTime,
      initialEntryMode: DatePickerEntryMode.input,
    );

    if (date == null) {
      return;
    }

    // For user feedback on completing the picking or input via calendar widget
    final String dateTimeText = ausFullDateDisplayFormat.format(date);

    dobTextController.text = dateTimeText;
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
      return dateFormatErrorMessage;
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
        veryOldMinimumStartBirthDate,
        currentDateTime,
      );
    }
    return null;
  }

  bool _isDateWithinRange(DateTime? date) {
    return date != null &&
        !date.isBefore(veryOldMinimumStartBirthDate) &&
        !date.isAfter(currentDateTime);
  }
}
