import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testable_web_app/shared/forms/date/widgets/input_custom_date_text_field.dart'
    show CustomInputDateTextFormField;

// ignore_for_file: avoid_redundant_argument_values,

void main() {
  Widget _customInputDateField({
    Key? key,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    ValueChanged<DateTime>? onDateSubmitted,
    ValueChanged<DateTime>? onDateSaved,
    SelectableDayPredicate? selectableDayPredicate,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
    bool autofocus = false,
    Key? formKey,
    ThemeData? theme,
  }) {
    return MaterialApp(
      theme: theme ?? ThemeData.from(colorScheme: const ColorScheme.light()),
      home: Material(
        child: Form(
          key: formKey,
          child: CustomInputDateTextFormField(
            key: key,
            initialDate: initialDate ??
                DateTime(
                  2016,
                  DateTime.january,
                  15,
                ),
            firstDate: firstDate ??
                DateTime(
                  2001,
                  DateTime.january,
                  1,
                ),
            lastDate: lastDate ??
                DateTime(
                  2031,
                  DateTime.december,
                  31,
                ),
            onDateSubmitted: onDateSubmitted,
            onDateSaved: onDateSaved,
            selectableDayPredicate: selectableDayPredicate,
            errorFormatText: errorFormatText,
            errorInvalidText: errorInvalidText,
            fieldHintText: fieldHintText,
            fieldLabelText: fieldLabelText,
            autofocus: autofocus,
          ),
        ),
      ),
    );
  }

  // Flutter library follows this convention rather than page object model
  // Single file simplez.

  TextField _textField(
    WidgetTester tester,
  ) {
    return tester.widget<TextField>(
      find.byType(TextField),
    );
  }

  /// To help get text from the field within the custom date input component.
  TextEditingController _textFieldController(
    WidgetTester tester,
  ) {
    return _textField(tester).controller!;
  }

  /// To check for invisible text when we are not showing hints fieldHintText
  double _textOpacity(
    WidgetTester tester,
    String textValue,
  ) {
    final FadeTransition opacityWidget = tester.widget<FadeTransition>(
      find
          .ancestor(
            of: find.text(textValue),
            matching: find.byType(FadeTransition),
          )
          .first,
    );
    return opacityWidget.opacity.value;
  }

  testWidgets('Enter invalid text; show errorFormat message', (
    WidgetTester tester,
  ) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    DateTime? inputDate;
    await tester.pumpWidget(
      _customInputDateField(
        onDateSaved: (DateTime date) => inputDate = date,
        formKey: formKey,
      ),
    );
    // Default errorFormat text
    expect(
      find.text('Invalid format.'),
      findsNothing,
    );
    await tester.enterText(
      find.byType(TextField),
      'foobar',
    );
    expect(
      formKey.currentState!.validate(),
      isFalse,
    );
    await tester.pumpAndSettle();
    expect(
      inputDate,
      isNull,
    );
    expect(
      find.text('Invalid format.'),
      findsOneWidget,
    );

    // Change to a custom errorFormat text
    await tester.pumpWidget(
      _customInputDateField(
        onDateSaved: (DateTime date) => inputDate = date,
        errorFormatText: 'That is not a date.',
        formKey: formKey,
      ),
    );
    expect(
      formKey.currentState!.validate(),
      isFalse,
    );
    await tester.pumpAndSettle();
    expect(
      find.text('Invalid format.'),
      findsNothing,
    );
    expect(
      find.text('That is not a date.'),
      findsOneWidget,
    );
  });

  testWidgets(
    'Enter date outside range; show bounds, show errorInvalid message',
    (
      WidgetTester tester,
    ) async {
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      DateTime? inputDate;
      await tester.pumpWidget(_customInputDateField(
        firstDate: DateTime(1967, DateTime.december, 31),
        lastDate: DateTime(2044, DateTime.october, 30),
        onDateSaved: (DateTime date) => inputDate = date,
        formKey: formKey,
      ));
      // Default errorInvalid text
      expect(find.text('Out of range.'), findsNothing);

      // Before first date in start date range
      await tester.enterText(find.byType(TextField), '02/28/1950');
      expect(formKey.currentState!.validate(), isFalse);
      await tester.pumpAndSettle();
      expect(
        inputDate,
        isNull,
      );
      expect(
        find.text('Out of range.'),
        findsOneWidget,
      );

      // After last date in end date range
      await tester.enterText(
        find.byType(TextField),
        '02/20/2050',
      );
      expect(
        formKey.currentState!.validate(),
        isFalse,
      );
      await tester.pumpAndSettle();
      expect(inputDate, isNull);
      expect(find.text('Out of range.'), findsOneWidget);

      // Show errorInvalid message even when changed
      // Probably should have this in a separate widget test.
      const String customChangedErrorInvalidMessage =
          'New invalid text: Not in given range.';
      await tester.pumpWidget(
        _customInputDateField(
          onDateSaved: (DateTime date) => inputDate = date,
          errorInvalidText: customChangedErrorInvalidMessage,
          formKey: formKey,
        ),
      );
      expect(formKey.currentState!.validate(), isFalse);
      await tester.pumpAndSettle();
      // ? pump new settle checks that changing the error text is changed
      // String literals more readable in testing conventions?
      expect(find.text('Out of range.'), findsNothing);
      expect(find.text(customChangedErrorInvalidMessage), findsOneWidget);
    },
  );
}
