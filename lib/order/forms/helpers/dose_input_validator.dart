String? doseInputValidator(String? input) {
  if (input == null) {
    return 'Please enter dose with the given units';
  }
  final double? doseValue = double.tryParse(input);

  if (doseValue == null) {
    return 'Invalid value detected. Please enter dose';
  }

  // Valid numeric dose value
  return null;
}
