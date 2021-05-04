import 'package:flutter/material.dart';

/// Otherwise we spam the user that they did something wrong in the first key
/// entering a single number!
/// UX anxiety
const AutovalidateMode disabledAutovalidatePreventEarlyPartialTextErrors =
    AutovalidateMode.disabled;

/// Fork of [InputDatePickerFormField]
///
///
/// To resolve buggy ux behaviour no automatic error message on invalid inputs
///
/// Documentation says it validates and presents error message on invalid input;
/// however, there is no call to `_validate()` !!!
///
/// Now we want to add validator trigger onSubmit that will not skip with null
/// The previous only triggered when validate is explicitly called
/// We want it onSubmit or even onSave to see the error message as soon as
/// possible
///
/// TextFormField should response to text inputs (/) it does pass `String?`
/// _handleSaved
///
/// no - triple checking again now
/// The callbacks are only run through _updateDate which only run the
/// `onDateSubmitted` and `onDateSaved` callbacks with valid date times
/// Which means we are unable to customise by default.
/// Which means we are also unable to trigger .validate() when datetime is null
/// which is when we actually want to see the validate error message in the
/// first place in response to potential text !!
///
///
/// Callback is only run when _isValidAcceptableDate . ParseDate is run first
///
///
/// Inspired original 2014 The Flutter Authors. All rights reserved.
/// Use of this source code is governed by a BSD-style license that can be
/// found in the LICENSE file in flutter base sdk library repo packaged.
///
/// A [TextFormField] configured to accept and validate a date entered by a user.
///
/// When the field is saved or submitted, the text will be parsed into a
/// [DateTime] according to the ambient locale's compact date format. If the
/// input text doesn't parse into a date, the [errorFormatText] message will
/// be displayed under the field.
///
/// [firstDate], [lastDate], and [selectableDayPredicate] provide constraints on
/// what days are valid. If the input date isn't in the date range or doesn't pass
/// the given predicate, then the [errorInvalidText] message will be displayed
/// under the field.
///
/// See also:
///
///  * [showDatePicker], which shows a dialog that contains a material design
///    date picker which includes support for text entry of dates.
///  * [MaterialLocalizations.parseCompactDate], which is used to parse the text
///    input into a [DateTime].
///
class CustomInputDateTextFormField extends StatefulWidget {
  /// Creates a [TextFormField] configured to accept and validate a date.
  ///
  /// If the optional [initialDate] is provided, then it will be used to populate
  /// the text field. If the [fieldHintText] is provided, it will be shown.
  ///
  /// If [initialDate] is provided, it must not be before [firstDate] or after
  /// [lastDate]. If [selectableDayPredicate] is provided, it must return `true`
  /// for [initialDate].
  ///
  /// [firstDate] must be on or before [lastDate].
  ///
  /// [firstDate], [lastDate], and [autofocus] must be non-null.
  ///
  CustomInputDateTextFormField({
    Key? key,
    DateTime? initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    this.controller,
    this.focusNode,
    this.onTextSubmitted,
    this.onDateSubmitted,
    this.onDateSaved,
    this.selectableDayPredicate,
    this.errorFormatText,
    this.errorInvalidText,
    this.fieldHintText,
    this.fieldLabelText,
    this.autofocus = false,
    // ignore: unnecessary_null_comparison
  })  : assert(firstDate != null),
        // ignore: unnecessary_null_comparison
        assert(lastDate != null),
        // ignore: unnecessary_null_comparison
        assert(autofocus != null),
        initialDate =
            initialDate != null ? DateUtils.dateOnly(initialDate) : null,
        firstDate = DateUtils.dateOnly(firstDate),
        lastDate = DateUtils.dateOnly(lastDate),
        super(key: key) {
    assert(!this.lastDate.isBefore(this.firstDate),
        'lastDate ${this.lastDate} must be on or after firstDate ${this.firstDate}.');
    assert(initialDate == null || !this.initialDate!.isBefore(this.firstDate),
        'initialDate ${this.initialDate} must be on or after firstDate ${this.firstDate}.');
    assert(initialDate == null || !this.initialDate!.isAfter(this.lastDate),
        'initialDate ${this.initialDate} must be on or before lastDate ${this.lastDate}.');
    assert(
        selectableDayPredicate == null ||
            initialDate == null ||
            selectableDayPredicate!(this.initialDate!),
        'Provided initialDate ${this.initialDate} must satisfy provided selectableDayPredicate.');
  }

  /// If provided, it will be used as the default value of the field.
  final DateTime? initialDate;

  /// The earliest allowable [DateTime] that the user can input.
  final DateTime firstDate;

  /// The latest allowable [DateTime] that the user can input.
  final DateTime lastDate;

  /// Allow parent to control controller in response to events like form
  /// saving/resetting.
  ///
  /// If no/null controller is provided, we instantiate our own in initState
  /// per default behaviour.
  ///
  final TextEditingController? controller;

  /// For parent form usability of auto focusing on submit/enter.
  ///
  /// Especially for manual desktop not driven by on-screen keyboard .next
  final FocusNode? focusNode;

  /// An optional method to call when the user indicates they are done editing
  /// the text in the field. Will only be called if the input represents a valid
  /// [DateTime].
  final ValueChanged<DateTime>? onDateSubmitted;

  /// Optional method to call on input text to provide more information when a
  /// user inputs an invalid date format [String]
  ///
  /// For error validation triggering.
  /// By parent form formKey.currentState.validate()
  final ValueChanged<String?>? onTextSubmitted;

  /// An optional method to call with the final date when the form is
  /// saved via [FormState.save]. Will only be called if the input represents
  /// a valid [DateTime].
  final ValueChanged<DateTime>? onDateSaved;

  /// Function to provide full control over which [DateTime] can be selected.
  final SelectableDayPredicate? selectableDayPredicate;

  /// The error text displayed if the entered date is not in the correct format.
  final String? errorFormatText;

  /// The error text displayed if the date is not valid.
  ///
  /// A date is not valid if it is earlier than [firstDate], later than
  /// [lastDate], or doesn't pass the [selectableDayPredicate].
  final String? errorInvalidText;

  /// The hint text displayed in the [TextField].
  ///
  /// If this is null, it will default to the date format string. For example,
  /// 'mm/dd/yyyy' for en_US.
  final String? fieldHintText;

  /// The label text displayed in the [TextField].
  ///
  /// If this is null, it will default to the words representing the date format
  /// string. For example, 'Month, Day, Year' for en_US.
  final String? fieldLabelText;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  @override
  _CustomInputDateTextFormFieldState createState() =>
      _CustomInputDateTextFormFieldState();
}

class _CustomInputDateTextFormFieldState
    extends State<CustomInputDateTextFormField> {
  late TextEditingController _controller;
  DateTime? _selectedDate;
  String? _inputText;
  bool _autoSelected = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateValueForSelectedDate();
  }

  @override
  void didUpdateWidget(CustomInputDateTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate) {
      // Can't update the form field in the middle of a build, so do it next frame
      WidgetsBinding.instance!.addPostFrameCallback((Duration timeStamp) {
        setState(() {
          _selectedDate = widget.initialDate;
          _updateValueForSelectedDate();
        });
      });
    }
  }

  void _updateValueForSelectedDate() {
    if (_selectedDate != null) {
      final MaterialLocalizations localizations =
          MaterialLocalizations.of(context);
      _inputText = localizations.formatCompactDate(_selectedDate!);
      TextEditingValue textEditingValue =
          _controller.value.copyWith(text: _inputText);
      // Select the new text if we are auto focused and haven't selected the text before.
      if (widget.autofocus && !_autoSelected) {
        textEditingValue = textEditingValue.copyWith(
            selection: TextSelection(
          baseOffset: 0,
          extentOffset: _inputText!.length,
        ));
        _autoSelected = true;
      }
      _controller.value = textEditingValue;
    } else {
      _inputText = '';
      _controller.value = _controller.value.copyWith(text: _inputText);
    }
  }

  DateTime? _parseDate(String? text) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return localizations.parseCompactDate(text);
  }

  bool _isValidAcceptableDate(DateTime? date) {
    return date != null &&
        !date.isBefore(widget.firstDate) &&
        !date.isAfter(widget.lastDate) &&
        (widget.selectableDayPredicate == null ||
            widget.selectableDayPredicate!(date));
  }

  String? _validateDate(DateTime date) {
    if (!_isValidAcceptableDate(date)) {
      return widget.errorInvalidText ??
          MaterialLocalizations.of(context).dateOutOfRangeLabel;
    }
    return null;
  }

  ///
  String? _validateDateText(String? text) {
    final DateTime? date = _parseDate(text);
    // Slightly confusing if-branching. Whether to exit error cases early
    // or null escape early.
    // Reverse convention with validators where null is the success message.
    //
    if (date == null) {
      // Do we handle invalid day month year inputs or silently wrap.
      // e.g. 0 = last day of the previous month.
      // 32 = extra days starting from the next month. 13 = next year january

      // A separate partial text checker function here?
      // Otherwise defaults to the invalid date format less-informative text.
      //

      return widget.errorFormatText ??
          MaterialLocalizations.of(context).invalidDateFormatLabel;
    }

    // Superfluous code deduplication
    // Kept in case SDK changes in the future. Or if we contribute to library
    // Retain as many of same anchor points as possible.
    //
    // May be more maintainable to absorb validateDate into this text function
    final String? validateDateFormatRangeErrorMessage = _validateDate(date);
    if (validateDateFormatRangeErrorMessage != null) {
      return validateDateFormatRangeErrorMessage;
    }

    return null;
  }

  void _updateDate(String? text, ValueChanged<DateTime>? callback) {
    final DateTime? date = _parseDate(text);
    if (_isValidAcceptableDate(date)) {
      _selectedDate = date;
      _inputText = text;
      callback?.call(_selectedDate!);
    }
  }

  void _handleSaved(String? text) {
    _updateDate(text, widget.onDateSaved);
  }

  void _handleSubmitted(String text) {
    /// Allow form to call validator or other functionality on raw submit
    /// Rather than wrapping focus changes or other alternatives.
    /// Not blocked by waiting for only valid date inputs.
    widget.onTextSubmitted?.call(text);

    _updateDate(text, widget.onDateSubmitted);
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final InputDecorationTheme inputTheme =
        Theme.of(context).inputDecorationTheme;

    return TextFormField(
      decoration: InputDecoration(
        border: inputTheme.border ?? const UnderlineInputBorder(),
        filled: inputTheme.filled,
        hintText: widget.fieldHintText ?? localizations.dateHelpText,
        labelText: widget.fieldLabelText ?? localizations.dateInputLabel,
      ),
      validator: _validateDateText,
      keyboardType: TextInputType.datetime,
      onSaved: _handleSaved,
      onFieldSubmitted: _handleSubmitted,
      autofocus: widget.autofocus,
      controller: _controller,
      focusNode: widget.focusNode,
      // Explicitly disable as we want to customise the partial interactions first
      // Do not show annoying red alert messages on first keystroke!
      //
      autovalidateMode: disabledAutovalidatePreventEarlyPartialTextErrors,
    );
  }
}
