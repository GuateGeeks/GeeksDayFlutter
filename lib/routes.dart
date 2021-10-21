import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/ui/email_create_screen.dart';
import 'package:geeksday/ui/email_signin_screen.dart';
import 'package:geeksday/ui/event_registration.dart';
import 'package:geeksday/ui/home.dart';
import 'package:geeksday/ui/intro_screen.dart';
import 'package:geeksday/ui/setting.dart';
import 'package:flutter/material.dart';
import 'package:geeksday/ui/user_profile.dart';

class Routes {

  static const intro = '/';
  static const eventRegistration = '/eventRegistration';
  static const home = '/home';
  static const userProfile = '/userProfile';
  static const settings = '/settings';
  static const creatPost = '/createPost';

  static const postComment = '/postComment';
  static const createAccount = '/createAccount';
  static const signInEmail = '/signInEmail';

  static Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case intro:
        return _buildRoute(IntroScreen.create); 
      case createAccount:
        return _buildRoute(EmailCreate.create);
      case signInEmail:
        return _buildRoute(EmailSignIn.create);
      case eventRegistration:
        return _buildRoute(EventRegistration.create);
      case home:
        return _buildRoute(Home.create);
      case userProfile:
        return _buildRoute(UserProfile.create);
      case settings:
        return _buildRoute(Settings.create);
      default:
        throw Exception('Route does not exists');
    }
  }

  static MaterialPageRoute _buildRoute(Function build) =>
      MaterialPageRoute(builder: (context) => build(context));
}
