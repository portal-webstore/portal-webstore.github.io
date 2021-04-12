import 'package:flutter/material.dart';
import 'package:testable_web_app/boilerplate/boilerplate_counter_screen.dart';
import 'package:testable_web_app/home_screen.dart';
import 'package:testable_web_app/login/login/screens/login_screen.dart';
import 'package:testable_web_app/login/screens/base_login_landing_app_screen.dart';
import 'package:testable_web_app/login/splash/screens/splash_screen.dart';
import 'package:testable_web_app/sample/counter/counter.dart';
import 'package:testable_web_app/sample/timer/screen/timer_screen.dart';
import 'package:testable_web_app/shared/navigation/routes_constant.dart';
import 'package:testable_web_app/webstore/catalogue/screens/product_catalogue_screen.dart'
    show ProductCatalogueScreen;

/// Extract routes generation here to remove noise from MaterialApp
///
/// Avoid in-lining multiple route code changes in MyApp every time we
/// need a screen or add a feature.
///
/// Deters diff history noise in MaterialApp.routes
/// Deters diff history noise in MaterialApp.onGenerateRoute
///
/// @Usage:
/// ```dart
/// Widget build(BuildContext context) {
///   return MaterialApp(
///     ...
///     onGenerateRoute: RoutesGenerator.getRouteOnGenerate,
///     ...
///   );
///
/// ```
///
///
class Router {
  /// "Static class" for namespacing
  const Router._();

  /// Use this instead of MaterialApp.routes
  ///
  /// Use this directly for MaterialApp.onGenerateRoute
  static Route getRouteOnGenerate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        // final args = settings.arguments;

        return MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomeScreen(),
          settings: settings,
        );

      case Routes.timer:
        // final args = settings.arguments;

        return MaterialPageRoute<void>(
          builder: (BuildContext context) => const TimerScreen(),
          settings: settings,
        );

      case Routes.boilerplateCounter:
        // final args = settings.arguments;

        return MaterialPageRoute<void>(
          builder: (BuildContext context) => const BoilerplateCounterScreen(),
          settings: settings,
        );

      case Routes.counter:
        return MaterialPageRoute<void>(
          builder: (BuildContext context) => const CounterScreen(),
          settings: settings,
        );

      case Routes.loginLanding:
        return MaterialPageRoute<void>(
          builder: (BuildContext context) => LoginAppLandingScreen(),
          settings: settings,
        );
      case Routes.loginLogin:
        return MaterialPageRoute<void>(
          builder: (BuildContext context) => const LoginLoginScreen(),
          settings: settings,
        );
      case Routes.loginSplash:
        return MaterialPageRoute<void>(
          builder: (BuildContext context) => const SplashScreen(),
          settings: settings,
        );

      case Routes.productCatalogue:
        return MaterialPageRoute<void>(
          builder: (BuildContext context) => const ProductCatalogueScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomeScreen(),
          settings: settings,
        );
    }
  }
}
