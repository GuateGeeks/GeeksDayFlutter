import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/services/navigationService.dart';
import 'package:geeksday/ui/admin/main.dart';
import 'package:geeksday/ui/admin/metrics/social_metrics.dart';
import 'package:geeksday/ui/configuration.dart';
import 'package:geeksday/ui/email_create_screen.dart';
import 'package:geeksday/ui/email_signin_screen.dart';
import 'package:geeksday/ui/event/main_event.dart';
import 'package:geeksday/ui/locator.dart';
import 'package:geeksday/ui/post/post_comment.dart';
import 'package:geeksday/ui/post/post_create.dart';
import 'package:geeksday/ui/post/post_list.dart';
import 'package:geeksday/ui/post/single_image_view.dart';
import 'package:geeksday/ui/user_profile.dart';

//Login handler
final loginHandler = Handler(handlerFunc: (context, _) {
  return EmailSignIn();
});
//Admin handler
final adminHandler = Handler(handlerFunc: (context, _) {
  locator<NavigationService>().setCurrentRoute("/admin");
  AuthUser? user = BlocProvider.of<AuthCubit>(context!).getUser();
  if (user != null && user!.isadmin) {
    return AdminPage();
  }
});
final socialMetricsHandler = Handler(handlerFunc: (context, _) {
  locator<NavigationService>().setCurrentRoute("/socialMetrics");
  AuthUser? user = BlocProvider.of<AuthCubit>(context!).getUser();
  if (user != null && user!.isadmin) {
    return SocialMetrics();
  }
});
//Registration Handler
final registrationHandler = Handler(handlerFunc: (context, _) {
  return EmailCreate();
});
//Configuration page handler
final configurationHandler = Handler(handlerFunc: (context, _) {
  return Configuration();
});
//Events page handler
final eventsHandler = Handler(handlerFunc: (context, _) {
  locator<NavigationService>().setCurrentRoute("/eventos");
  AuthUser? user = BlocProvider.of<AuthCubit>(context!).getUser();
  if (user != null) {
    return MainEvent();
  }
});
final createPostHandler = Handler(handlerFunc: (context, params) {
  AuthUser? user = BlocProvider.of<AuthCubit>(context!).getUser();
  if (user != null) {
    return PostCreate(idEvent: params['id']!.first);
  }
});
//Post page handler
final postsHandler = Handler(handlerFunc: (context, params) {
  locator<NavigationService>()
      .setCurrentRoute("/evento/${params['id']!.first}");
  AuthUser? user = BlocProvider.of<AuthCubit>(context!).getUser();
  if (user != null) {
    return PostList(idEvent: params['id']!.first);
  }
});

//Single image page handler
final singleImage = Handler(handlerFunc: (context, params) {
  return SingleImageView(
    idEvent: params['id']!.first,
    idPost: params['idPost']!.first,
  );
});

//User profile handler
final userProfileHandler = Handler(handlerFunc: (context, params) {
  locator<NavigationService>()
      .setCurrentRoute("/perfil/${params['idUser']!.first}");
  AuthUser? user = BlocProvider.of<AuthCubit>(context!).getUser();
  if (user != null) {
    return UserProfile(idUser: params['idUser']!.first);
  }
});

//Comments page handler
final commentsHandler = Handler(handlerFunc: (context, params) {
  return PostComment(
      idPost: params['idPost']!.first, idEvent: params['id']!.first);
});
