
import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/ui/router/router_handlers.dart';

class Flurorouter{
  static final FluroRouter router = new FluroRouter();

  static void configureRoutes(){
    //Login route
    router.define('/login', handler: loginHandler, transitionType: TransitionType.none);
    //Registration route
    router.define('/registrarse', handler: registrationHandler, transitionType: TransitionType.none);
    //configuration page route
    router.define('/configuracion', handler: configurationHandler, transitionType: TransitionType.none);
    //Events route
    router.define('/eventos', handler: eventsHandler, transitionType: TransitionType.none); 
    //Create a new post route
    router.define('/evento/:id/publicacion', handler: createPostHandler, transitionType: TransitionType.none);
    //Posts page route
    router.define('/evento/:id', handler: postsHandler, transitionType: TransitionType.none); 
    //Single image page route
    router.define('/evento/:id/publicacion/:idPost/imagen', handler: singleImage, transitionType: TransitionType.none);
    //User profile page route
    router.define('perfil/:idUser', handler: userProfileHandler, transitionType: TransitionType.none);
    //Comments page route
    router.define('/evento/:id/publicacion/:idPost/comentarios', handler: commentsHandler, transitionType: TransitionType.none);
  }


}