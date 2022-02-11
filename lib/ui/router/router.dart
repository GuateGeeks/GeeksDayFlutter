
import 'package:fluro/fluro.dart';
import 'package:geeksday/ui/router/router_handlers.dart';

class Flurorouter{
  static final FluroRouter router = new FluroRouter();

  static void configureRoutes(){
    //Login route
    router.define('/login', handler: loginHandler, transitionType: TransitionType.none);
    //Registration route
    router.define('/registration', handler: registrationHandler, transitionType: TransitionType.none);
  
  
  
  }


}
