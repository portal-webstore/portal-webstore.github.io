import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, ReadContext;
import 'package:testable_web_app/sample/counter/counter.dart' show CounterCubit;
import 'package:testable_web_app/sample/counter/widgets/counter_view_widget.dart'
    show CounterView;

/// This example is better. Updated lints, Null safety, updated mocktail dep.
/// {@template counter_widget}
///
/// A [StatelessWidget] which provides a
/// [CounterCubit] instance to the [Counter] widget.
///
/// {@endtemplate}
///
class CounterScreen extends StatelessWidget {
  /// {@macro counter_screen}
  const CounterScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(
        key: Key('CounterViewKey'),
        textStyle: null,
      ),
    );
  }
}
