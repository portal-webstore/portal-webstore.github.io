import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show debugPrint;

/// {@template counter_observer}
/// [BlocObserver] for the counter application which
/// observes all [Bloc] state changes.
/// {@endtemplate}
class CounterObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    debugPrint('CounterObserver onTransition ${bloc.runtimeType} $transition');
  }

  /// Bloc documentation sample also failed again here!
  /// They talked about onChange when they created code for onTransition...
  ///
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc as BlocBase<int>, change as Change<int>);
    // ignore: avoid_print
    debugPrint('CounterObserver.onChange ${bloc.runtimeType} $change');
  }
}
