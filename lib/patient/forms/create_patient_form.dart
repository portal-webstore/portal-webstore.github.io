import 'package:flutter/material.dart';
import 'package:testable_web_app/i18n/date/australia_date_locale_format.dart';
import 'package:testable_web_app/order/forms/helpers/get_date_out_of_range_invalid_error_message.dart';
import 'package:testable_web_app/order/forms/helpers/validate_form_on_focus_out.dart';

class CreatePatientForm extends StatefulWidget {
  const CreatePatientForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

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
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Record number (URN/MRN)',
            helperText: '',
          ),
          validator: (input) => null,
          onSaved: (String? text) {
            //
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Last name',
            helperText: '',
          ),
          validator: (input) => null,
          onSaved: (String? text) {
            //
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'First name',
            helperText: '',
          ),
          validator: (input) => null,
          onSaved: (String? text) {
            //
          },
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
                    helperText: '',
                  ),
                  controller: dobTextController,
                  validator: (String? text) {
                    if (text == null) {
                      return MaterialLocalizations.of(context)
                          .invalidDateFormatLabel;
                    }

                    return _validateDateText(text);
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
      ],
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
    widget.formKey.currentState?.validate();
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
