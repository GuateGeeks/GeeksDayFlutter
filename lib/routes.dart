import 'package:geeksday/ui/email_create_screen.dart';
import 'package:geeksday/ui/email_signin_screen.dart';
import 'package:geeksday/ui/home.dart';
import 'package:geeksday/ui/intro_screen.dart';
import 'package:geeksday/ui/post/post_create.dart';
import 'package:geeksday/ui/post/post_comment.dart';
import 'package:geeksday/ui/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const home = '/home';
  static const creatPost = '/createPost';

  static const postComment = '/postComment';
  static const createAccount = '/createAccount';
  static const signInEmail = '/signInEmail';

  static Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return _buildRoute(SplashScreen.create);
      case intro:
        return _buildRoute(IntroScreen.create);
      case createAccount:
        return _buildRoute(EmailCreate.create);
      case signInEmail:
        return _buildRoute(EmailSignIn.create);
      case home:
        return _buildRoute(Home.create);
      case postComment:
        return _buildRoute(PostComment.create);
      default:
        throw Exception('Route does not exists');
    }
  }

  static MaterialPageRoute _buildRoute(Function build) =>
      MaterialPageRoute(builder: (context) => build(context));
}
