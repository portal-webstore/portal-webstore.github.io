import 'package:bloc/bloc.dart' show Bloc, BlocObserver, Transition;
import 'package:flutter/material.dart' show debugPrint;

/// {@template counter_observer}
/// [BlocObserver] for the counter application which
/// observes all [Bloc] state changes.
/// {@endtemplate}
class CounterObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    debugPrint('${bloc.runtimeType} $transition');
  }
}
