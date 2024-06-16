import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future navigateTo(String routeName, {Object ?arguments}) {
  return  navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static popUntilTo(String routeName) {
    return navigatorKey.currentState!.popUntil((route) {
      return route.settings.name == routeName;
    });
  }
  static popUntilToLastRoute() {
    return navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  static Future navigateReplacementTo(String routeName, {Object ?arguments}) {
    return  navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future navigateAndRemoveUntil(String routeName, {Object ?arguments}) {
    return   navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false, arguments: arguments);
  }

  static  goBack({data}) {
    navigatorKey.currentState!.pop(data??true);
  }
}
