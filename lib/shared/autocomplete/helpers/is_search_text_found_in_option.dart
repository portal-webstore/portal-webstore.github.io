typedef TextFromOptionFn<T> = String Function(T opt);

/// Usually reuse the display view model as the searchable option text as well
/// For consistency
///
/// Though can pass in a different option text getter
///
bool isSearchTextFoundInOption<T>(
  T option,
  String searchText,
  TextFromOptionFn<T> getTextFromOption,
) {
  final String optionText = getTextFromOption(option);

  final String lowerCasedOption = optionText.toLowerCase();
  final String lowerCasedSearch = searchText.toLowerCase();

  return lowerCasedOption.contains(lowerCasedSearch);
}
