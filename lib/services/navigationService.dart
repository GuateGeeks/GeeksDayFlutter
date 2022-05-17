import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  String _currentRoute = '/eventos';

  Future navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  void setCurrentRoute(String routeName) {
    _currentRoute = routeName;
  }

  String get currentRoute => _currentRoute;

  void goBack(String routeName) {
    return navigatorKey.currentState!.pop();
  }
}
