import 'package:flutter/material.dart';
import 'package:testable_web_app/i18n/date/australia_date_locale_format.dart';

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
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'DOB',
            helperText: 'dd/MM/yyyy',
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
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Date of birth',
                  helperText: '',
                ),
                controller: dobTextController,
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
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        // 123 years old?
        const Duration(
          days: 365 * 123,
        ),
      ),
      lastDate: DateTime.now(),
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
}
