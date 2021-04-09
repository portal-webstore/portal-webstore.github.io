import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testable_web_app/sample/counter/counter.dart';
import 'package:testable_web_app/sample/counter/widgets/counter_view_widget.dart';

class MockCounterCubit extends MockCubit<int> implements CounterCubit {}

const _incrementButtonKey = Key(
  '+increment_counterScreen_floatingActionButton',
);
const _decrementButtonKey = Key(
  '-decrement_counterScreen_floatingActionButton',
);

void main() {
  late CounterCubit counterCubit;

  setUp(() {
    counterCubit = MockCounterCubit();
  });

  group('CounterView', () {
    testWidgets('renders current CounterCubit state', (tester) async {
      when(() => counterCubit.state).thenReturn(42);
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: counterCubit,
            child: const CounterView(
              textStyle: null,
            ),
          ),
        ),
      );
      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('tapping increment button invokes increment', (tester) async {
      when(() => counterCubit.state).thenReturn(0);
      when(() => counterCubit.increment()).thenReturn(() {});
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: counterCubit,
            child: const CounterView(
              textStyle: null,
            ),
          ),
        ),
      );
      await tester.tap(find.byKey(_incrementButtonKey));
      verify(() => counterCubit.increment()).called(1);
    });

    testWidgets('tapping decrement button invokes decrement', (tester) async {
      when(() => counterCubit.state).thenReturn(0);
      when(() => counterCubit.decrement()).thenReturn(() {});
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: counterCubit,
            child: const CounterView(
              textStyle: null,
            ),
          ),
        ),
      );
      final decrementFinder = find.byKey(_decrementButtonKey);
      await tester.ensureVisible(decrementFinder);
      await tester.tap(decrementFinder);
      verify(() => counterCubit.decrement()).called(1);
    });
  });
}
