import 'package:flutter/material.dart' show runApp;
import 'package:testable_web_app/my_app.dart' show MyApp;
import 'package:testable_web_app/sample/counter/observers/counter_observer.dart';

void main() {
  CounterObserver();

  runApp(
    const MyApp(),
  );
}
