
import 'package:fluro/fluro.dart';
import 'package:geeksday/ui/router/router_handlers.dart';

class Flurorouter{
  static final FluroRouter router = new FluroRouter();

  static void configureRoutes(){
    //Login route
    router.define('/login', handler: loginHandler, transitionType: TransitionType.none);
    //Registration route
    router.define('/registrarse', handler: registrationHandler, transitionType: TransitionType.none);
    //Events route
    router.define('/eventos', handler: eventsHandler, transitionType: TransitionType.none);  
  }


}
