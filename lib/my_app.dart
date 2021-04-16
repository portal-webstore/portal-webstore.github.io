import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalMaterialLocalizations, GlobalWidgetsLocalizations;
import 'package:intl/date_symbol_data_local.dart' show initializeDateFormatting;
import 'package:testable_web_app/home_screen.dart' show HomeScreen;
import 'package:testable_web_app/i18n/date/australia_date_locale_format.dart'
    show en_AU;
import 'package:testable_web_app/i18n/localisation/australian/australian_localisation_delegate.dart'
    show AustralianLocalisationDelegate;
import 'package:testable_web_app/shared/navigation/route_generator.dart' as r
    show Router;
import 'package:testable_web_app/shared/themes/custom_material_theme.dart'
    show customMaterialTheme;

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(en_AU);

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
      theme: customMaterialTheme,
      home: const HomeScreen(
        title: 'Flutter webstore portal demo home page',
      ),
      onGenerateRoute: r.Router.getRouteOnGenerate,
    );
  }
}
