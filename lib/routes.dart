import 'package:geeksday/ui/email_create_screen.dart';
import 'package:geeksday/ui/email_signin_screen.dart';
import 'package:geeksday/ui/event/main_event.dart';

import 'package:flutter/material.dart';
import 'package:geeksday/ui/splash_screen.dart';
import 'package:geeksday/ui/user_profile.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const home = '/home';
  static const mainEvent = '/mainEvent';
  static const userProfile = '/userProfile';
  static const settings = '/settings';

  static const postComment = '/postComment';
  static const createAccount = '/createAccount';
  static const signInEmail = '/signInEmail';

  static Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return _buildRoute(SplashScreen.create);
      case createAccount:
        return _buildRoute(EmailCreate.create);
      case signInEmail:
        return _buildRoute(EmailSignIn.create);
      default:
        throw Exception('Route does not exists');
    }
  }

  static MaterialPageRoute _buildRoute(Function build) =>
      MaterialPageRoute(builder: (context) => build(context));
}
