import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../counter.dart';

const incrementButtonKey = '+increment_counterScreen_floatingActionButton';
const decrementButtonKey = '-decrement_counterScreen_floatingActionButton';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter screen'),
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text(
              '$state',
              style: textStyle ?? Theme.of(context).textTheme.headline2,
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            key: const Key(incrementButtonKey),
            heroTag: incrementButtonKey,
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
            key: const Key(decrementButtonKey),
            heroTag: decrementButtonKey,
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
