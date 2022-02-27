import 'package:fluro/fluro.dart';
import 'package:geeksday/ui/configuration.dart';
import 'package:geeksday/ui/email_create_screen.dart';
import 'package:geeksday/ui/email_signin_screen.dart';
import 'package:geeksday/ui/event/main_events.dart';
import 'package:geeksday/ui/post/post_comment.dart';
import 'package:geeksday/ui/post/post_list.dart';
import 'package:geeksday/ui/post/single_image_view.dart';
import 'package:geeksday/ui/user_profile.dart';

//Login handler
final loginHandler = Handler(handlerFunc: (context, _) {
  return EmailSignIn();
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
  return MainEvent();
});
//Post page handler
final postsHandler = Handler(handlerFunc: (context, params) {
  return PostList(idEvent: params['id']!.first);
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
  return UserProfile(idUser: params['idUser']!.first);
});

//Comments page handler
final commentsHandler = Handler(handlerFunc: (context, params) {
  return PostComment(
      idPost: params['idPost']!.first, idEvent: params['id']!.first);
});
