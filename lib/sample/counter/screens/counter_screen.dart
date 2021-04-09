import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, ReadContext;
import 'package:testable_web_app/sample/counter/counter.dart' show CounterCubit;
import 'package:testable_web_app/sample/counter/widgets/counter_text_view_widget.dart'
    show CounterTextView;

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
        child: BlocProvider(
          create: (_) => CounterCubit(),
          child: CounterTextView(
            textStyle: textTheme.headline2,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            key: const Key('+increment_counterScreen_floatingActionButton'),
            heroTag: '+increment_counterScreen_floatingActionButton',
            onPressed: () {
              /// Provider provider.dart read(). Exposed through flutter_bloc extension
              /// [ReadContext]
              ///
              /// Call read() only in event handlers like onPressed.
              ///
              /*
                Widget build(BuildContext context) {
                  counter is used only for the onPressed of RaisedButton

                  final counter = context.read<Counter>();
                  return RaisedButton(
                    onPressed: () => counter.increment(),
                  );
                }
                While this code is not bugged in itself, this is an anti-pattern. 
                It could easily lead to bugs in the future after refactoring the widget to use 
                counter for other things, but forget to change [read] into [watch].
                
                CONSIDER calling [read] inside event handlers:
              */

              context.read<CounterCubit>().increment();
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            key: const Key('-decrement_counterScreen_floatingActionButton'),
            heroTag: '-decrement_counterScreen_floatingActionButton',
            onPressed: () {
              context.read<CounterCubit>().decrement();
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
