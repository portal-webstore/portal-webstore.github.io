import 'package:bloc/bloc.dart';

/// {@template counter_cubit}
/// A [Cubit] which manages an [int] as its state.
/// {@endtemplate}
class CounterCubit extends Cubit<int> {
  /// {@macro counter_cubit}
  CounterCubit() : super(initialCount);

  /// initialState for Cubit initialiser
  static const initialCount = 0;

  /// Increment state by 1 by default
  void increment({int step = 1}) => emit(state + step);

  /// Decrement state by 1 by default
  void decrement({int step = 1}) => emit(state - step);
}
