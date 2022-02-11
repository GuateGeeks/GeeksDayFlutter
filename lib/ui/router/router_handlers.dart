

import 'package:fluro/fluro.dart';
import 'package:geeksday/ui/email_create_screen.dart';
import 'package:geeksday/ui/email_signin_screen.dart';
import 'package:geeksday/ui/events/main_events.dart';

//Login handler
final loginHandler = Handler(
  handlerFunc: (context, _){
    return EmailSignIn();
  }
);

//Registration Handler
final registrationHandler = Handler(
  handlerFunc: (context, _){
    return EmailCreate();
  }
);

final eventsHandler = Handler(
  handlerFunc: (context, _){
    return MainEvents();
  }
);

