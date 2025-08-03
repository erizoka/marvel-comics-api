import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic>? navigateTo(Widget page) {
    return navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static Future<dynamic>? replaceWith(Widget page) {
    return navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static void goBack() {
    return navigatorKey.currentState?.pop();
  }

  static void popUntilRoot() {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }
}
