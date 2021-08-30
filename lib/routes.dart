import 'package:flutter/material.dart';
import 'package:mytv/screens/dashboard.dart';
import 'package:mytv/screens/loginScreen.dart';

class Routes {
  Routes._();

  // routes
  static const initScreen = '/init-screen';
  static const login = '/login';
  static const signup = '/signup';
  static const dashboard = '/dashboard';

  /// Routing Table needed for the App.
  static Map<String, WidgetBuilder> get buildRoutes {
    return {
      login: (BuildContext context) => Login(),
     dashboard: (BuildContext context) => DashboardContainer(),

      // offsetLanding: (BuildContext context) => BaseLayout(
      //       page: OffsetLanding(),
      //       isAppBar: false,
      //       activePageIndex: 4,
      //     ),
    };
  }

  /// Handler for Error and Unhandled pages.
  static Function get unknownRoute {
    return (settings) {
      MaterialPageRoute(
        builder: (ctx) => Login(),
      );
    };
  }

  /// Configures the initial route.
  static String get initialRoute {
    return Routes.login;
  }
}
