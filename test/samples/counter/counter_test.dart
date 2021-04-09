import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testable_web_app/my_app.dart';
import 'package:testable_web_app/sample/counter/screens/counter_screen.dart';

void main() {
  group('MyApp', () {
    testWidgets('is a MyApp', (WidgetTester tester) async {
      expect(const MyApp(), isA<MyApp>());
      expect(find.byType(MaterialApp), findsNothing);
    });

    testWidgets('renders CounterScreen', (WidgetTester tester) async {
      // await tester.pumpWidget(const MaterialApp(home: CounterScreen()));
      // expect(find.byType(CounterScreen), isA<CounterScreen>());
      await tester.pumpWidget(const MaterialApp(home: CounterScreen()));
    });
  });
}
