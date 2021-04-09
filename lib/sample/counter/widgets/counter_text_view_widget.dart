import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../counter.dart';

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [CounterCubit] state and notifies it in response to user input.
/// {@endtemplate}
class CounterTextView extends StatelessWidget {
  const CounterTextView({
    Key? key,
    required this.textStyle,
  }) : super(key: key);

  /// e.g. Theme.of(context).textTheme
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, int>(
      builder: (context, state) {
        return Text(
          '$state',
          style: textStyle ?? Theme.of(context).textTheme.headline2,
        );
      },
    );
  }
}
