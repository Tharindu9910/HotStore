import 'package:flutter/material.dart';
import 'package:hot_store1/screens/bottom_navigation_screen.dart';
import 'package:hot_store1/screens/home/view_product_screen.dart';
//import 'package:hot_store1/screens/splash_screen.dart';

import 'home/home_screen.dart';

class AppRouter {
  static const String homeScreen = "/homeScreen",
      bottomNavigationScreen = "/bottomNavigationScreen",
      viewProductScreen = "/viewProductScreen";

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );
      case bottomNavigationScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const BottomNavScreen(),
        );
      case viewProductScreen:
        ViewProductArgs args;
        if (routeSettings.arguments != null) {
          args = routeSettings.arguments as ViewProductArgs;
        } else {
          args = ViewProductArgs(productID: 1);
        }
        return MaterialPageRoute(
          builder: (BuildContext context) => ViewProductScreen(args: args),
        );
      default:
        return null;
    }
  }
}
