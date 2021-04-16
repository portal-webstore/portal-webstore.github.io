import 'package:bloc/bloc.dart' show Bloc;
import 'package:flutter/material.dart' show runApp;
import 'package:intl/intl.dart';
import 'package:testable_web_app/my_app.dart' show MyApp;
import 'package:testable_web_app/sample/counter/observers/counter_observer.dart';

void main() {
  Bloc.observer = CounterObserver();
  Intl.defaultLocale = 'en_AU';

  runApp(
    const MyApp(),
  );
}
