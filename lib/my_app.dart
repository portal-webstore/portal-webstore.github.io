import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalMaterialLocalizations, GlobalWidgetsLocalizations;
import 'package:testable_web_app/home_screen.dart' show HomeScreen;
import 'package:testable_web_app/i18n/localisation/australian/australian_localisation_delegate.dart'
    show AustralianLocalisationDelegate;
import 'package:testable_web_app/shared/navigation/route_generator.dart' as r
    show Router;

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter webstore portal demo app',
      localizationsDelegates: const [
        AustralianLocalisationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'AU'), // English (Australia)
        Locale('en', 'US'), // English (United States) for safe defaults
      ],
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(
        title: 'Flutter webstore portal demo home page',
      ),
      onGenerateRoute: r.Router.getRouteOnGenerate,
    );
  }
}
