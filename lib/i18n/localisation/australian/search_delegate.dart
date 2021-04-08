import 'package:flutter/material.dart';

/// Unused code :fire: 🔥
@Deprecated(
  'For showSearch(). '
  'Not currently using this for anything. '
  'May have used get searchFieldLabel instead',
)
class DummySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) => [];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      );

  @override
  Widget buildResults(BuildContext context) => const Text('Result');

  @override
  Widget buildSuggestions(BuildContext context) => const Text('Suggestion');
}

@Deprecated(
  'For showSearch(). '
  'Not currently using this for anything. '
  'May have used get searchFieldLabel instead',
)
class DummySearchSampleDelegate extends SearchDelegate<String> {
  DummySearchSampleDelegate({
    String hintText = 'Sample search hint',
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) => const Text('Result');

  @override
  Widget buildSuggestions(BuildContext context) => const Text('Suggestion');
}
