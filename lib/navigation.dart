import 'package:flutter/material.dart';

import 'package:praiseboard/routes.dart';

///  [Navigation] is common place for Navigation utils.
///  This includes push, pop, pushNamed methods from Navigator.of(context).
///  Common Place for all navigation utilities.
///  Use [Navigation] like this:
///   ```dart
///   Navigation.pushNamed(context, Routes.login);
///   Navigation.pop();
///   Navigation.pushReplacementNamed(context, 'dashboard');
///   Navigation.pushNamedAndRemoveUntil(context, 'lohin',arguments);
///   ```
///
class Navigation {
  Navigation._();
  static dynamic pushNamed(BuildContext context, String routeName,
      [Object arguments]) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static dynamic pushReplacementNamed(BuildContext context, String routeName,
      [Object arguments]) {
    Navigator.of(context).pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  // Calls pop repeatedly on the navigator that most tightly
  // encloses the given context until the predicate returns true.
  ///   ```dart
  ///  Navigation.popUntil(context, '/login');
  ///   ```
  static dynamic popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  /// Removes all the routes from stack and given route is pushed
  ///   ```dart
  ///  Navigation.pushNamedAndRemoveUntil(context, '/login',arguments);
  ///   ```
  static dynamic pushNamedAndRemoveUntil(BuildContext context, String routeName,
      [Object arguments]) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false,
        arguments: arguments);
  }

  static dynamic pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// [popAndPushNamed] - Pop the current route off the navigator and push a named route in its place.
  static dynamic popAndPushNamed(BuildContext context, String routeName,
      [Object arguments]) {
    Navigator.of(context).popAndPushNamed(routeName, arguments: arguments);
  }

  static bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  /// A Navigator observer that notifies [RouteAwares] of changes to the state of their Route.
  /// Used with the mixin [RouteAware]
  /// RouteObserver informs subscribers whenever a route of type R is pushed on top of their own route of type R or popped from it.
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// [canPushNamed] used to avoid pushing the same route continuously
  static void canPushNamed({
    BuildContext context,
    String routeName,
    NavigationType routeType = NavigationType.PUSH_NAMED,
    String removeUntilRoute = Routes.dashboard,
  }) {
    Route route = ModalRoute.of(context);
    final existingRouteName = route?.settings?.name;
    if (routeName != null && routeName != existingRouteName) {
      switch (routeType) {
        case NavigationType.PUSH_NAMED:
          Navigator.of(context).pushNamed(routeName);
          break;
        case NavigationType.PUSH_REPLACEMENT_NAMED:
          Navigator.of(context).pushReplacementNamed(routeName);
          break;
        case NavigationType.PUSH_NAMED_AND_REMOVE_UNTIL:
          Navigator.pushNamedAndRemoveUntil(context, routeName,
              (route) => route.settings.name == removeUntilRoute);
      }
    }
  }
}

enum NavigationType {
  PUSH_NAMED,
  PUSH_REPLACEMENT_NAMED,
  PUSH_NAMED_AND_REMOVE_UNTIL,
}
