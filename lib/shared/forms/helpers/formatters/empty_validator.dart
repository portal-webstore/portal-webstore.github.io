String? validateEmpty(String? value) {
  if (value == null) {
    return null;
  }

  if (value.isEmpty) {
    return 'Please enter a value';
  }

  return null;
}
