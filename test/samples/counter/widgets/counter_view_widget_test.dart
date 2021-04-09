import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' show verify, when;
import 'package:testable_web_app/sample/counter/counter.dart';
import 'package:testable_web_app/sample/counter/widgets/counter_view_widget.dart';

class MockCounterCubit extends MockCubit<int> implements CounterCubit {}

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
      when(() => counterCubit.increment());
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
      await tester.tap(find.byKey(CounterView.incrementButtonKey));
      verify(() => counterCubit.increment()).called(1);
    });

    testWidgets('tapping decrement button invokes decrement', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1200, 1200);

      final CounterCubit counterCubitToDecrement = MockCounterCubit();
      // Flutter test race condition work around
      // widget test passes if run individually; however,
      // if we run the whole test suite, the last test always fails!
      //
      // i.e. if we switch the increment and decrement tests with each other
      // the other one fails (the test that is run last will fail)

      when(() => counterCubitToDecrement.state).thenReturn(0);
      when(() => counterCubitToDecrement.decrement());
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: counterCubitToDecrement,
            child: const CounterView(
              textStyle: null,
            ),
          ),
        ),
      );

      final decrementFinder = find.byKey(CounterView.decrementButtonKey);
      await tester.ensureVisible(decrementFinder);
      await tester.tap(decrementFinder);

      verify(() => counterCubitToDecrement.decrement()).called(1);
    });
  });
}
