typedef TextFromOptionFn<T> = String Function(T opt);

typedef IsOptionMatchedFromSearchTextFn<T> = bool Function(
  T option,
  String searchText,
);

class AutocompleteTextOption {
  /// Namespaced only for static utilities
  /// Should not be instantiated
  const AutocompleteTextOption._();

  /// Usually reuse the display view model as the searchable option text as well
  /// For consistency
  ///
  /// Though can pass in a different option text getter
  ///
  static bool isSearchTextFoundInOption<T>(
    T option,
    String searchText,
    TextFromOptionFn<T> getTextFromOption,
  ) {
    final String optionText = getTextFromOption(option);

    final String lowerCasedOption = optionText.toLowerCase();
    final String lowerCasedSearch = searchText.toLowerCase();

    return lowerCasedOption.contains(lowerCasedSearch);
  }

  /// YAGNI.
  /// Abstraction is less readable with minimal benefit compared to the concrete
  /// implementation per autocomplete widget.
  ///
  /// Helps only to enforce consistent shape
  ///
  /// then we would refactor into separate libraries though
  ///
  /// better if we start using a multitude of text-only search autocompleters.
  ///
  /// See
  /// ```dart
  ///    return options.where(
  ///      (ProductModel option) => isSearchTextFoundInProductOption(
  ///        option,
  ///        searchText,
  ///      ),
  ///    );
  ///
  ///    // Compared with
  ///    return getOptionsFilteredBy(
  ///      options,
  ///      searchText,
  ///      isSearchTextFoundInProductOption,
  ///    );
  ///```
  ///
  static Iterable<T> getOptionsFilteredBy<T>(
    Iterable<T> options,
    String searchText,
    IsOptionMatchedFromSearchTextFn<T> isOptionMatchedFromSearchTextFn,
  ) {
    return options.where(
      (T option) => isOptionMatchedFromSearchTextFn(
        option,
        searchText,
      ),
    );
  }
}
