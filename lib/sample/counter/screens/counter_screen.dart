import 'package:flutter/material.dart';

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
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter screen'),
      ),
      body: Center(
        child: Text(
          'Placeholder count',
          style: textTheme.headline2,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            key: const Key('+increment_counterScreen_floatingActionButton'),
            heroTag: '+increment_counterScreen_floatingActionButton',
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            key: const Key('-decrement_counterScreen_floatingActionButton'),
            heroTag: '-decrement_counterScreen_floatingActionButton',
            onPressed: () {},
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
