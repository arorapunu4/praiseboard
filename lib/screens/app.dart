import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:praiseboard/navigation.dart';
import 'package:praiseboard/responsiveness.dart';
import 'package:praiseboard/routes.dart';



class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Responsiveness.init();


    return 
    Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
      },
    child:MaterialApp(
        title: 'Praise Board',
        debugShowCheckedModeBanner: false,
       // theme: Themes.buildLightTheme(),
        initialRoute: Routes.initScreen,
        routes: Routes.buildRoutes,
        onUnknownRoute: Routes.unknownRoute,
        navigatorKey: Navigation.navigatorKey,
        navigatorObservers: [
          Navigation.routeObserver
        ],
      ),
    );

  }
}
