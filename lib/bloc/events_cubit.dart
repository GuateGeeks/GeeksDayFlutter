
import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/models/events.dart';
import 'package:geeksday/services/implementation/auth_service.dart';
import 'package:geeksday/services/implementation/events_service.dart';
import 'package:random_password_generator/random_password_generator.dart';


class EventsCubit extends Cubit<EventsState>{
  final EventsService _eventsService;
  File? _pickedImage;
  EventsCubit(this._eventsService) : super(EventsInitalState()){
    getEventsList();
  }

  List<Events> _list = [];

  Future<void> getEventsList() async{
    _list = await _eventsService.getEventsList();
    var _state = EventsInitalState();
    _state.listEvents.addAll(_list);
    emit(_state);
  }

  Future<void> createEvent(String eventName, String eventCodigo) async {
    var createEvent = Events.newEvents(eventName, eventCodigo);
    if(_pickedImage == null ){
      _eventsService.createEvent(createEvent);
    }else{
      _eventsService.createEventImage(createEvent, _pickedImage!);
    }
  }

  void addUserToEvent(String eventCode){
    print("agregando usuario al evento");
  }

  Future<String> getImageURL(String uid) {
    return _eventsService.getImageURL(uid);
  }

  void setImage(File? image) { 
    _pickedImage = image;
  }
  
  String codigoRandom(){
    final codigo = RandomPasswordGenerator();
    return codigo.randomPassword(
      letters: true,
      numbers: true,
      passwordLength: 6,
      uppercase: true,
      specialChar: false,
    );
  }

}








abstract class EventsState{
  bool isBusy = false;
  List<Events> listEvents = [];
}

class EventsInitalState implements EventsState{
  @override 
  bool isBusy = false;

  @override  
  List<Events> listEvents = [];
}









// import 'dart:html';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geeksday/models/events.dart';
// import 'package:geeksday/services/implementation/events_service.dart';
// import 'package:random_password_generator/random_password_generator.dart';

// class EventsCubit extends Cubit<EventsState>{
//   final EventsService _eventsService;
//   File? _pickedImage;

//   EventsCubit(this._eventsService): super(EventsInitialState());

//   Future getEventsList() async {
//     return _eventsService.getEventsList();
//   }

//   Future<void> createEvent(String eventName, String eventCodigo) async {
//     var createEvent = Events.newEvents(eventName, eventCodigo);
//     if(_pickedImage == null ){
//       _eventsService.createEvent(createEvent);
//     }else{
//       _eventsService.createEventImage(createEvent, _pickedImage!);
//     }
//   }

//   void setImage(File? image) { 
//     _pickedImage = image;
//   }

//   String codigoRandom(){
//     final codigo = RandomPasswordGenerator();
//     return codigo.randomPassword(
//       letters: true,
//       numbers: true,
//       passwordLength: 6,
//       uppercase: true,
//       specialChar: false,
//     );
//   }
// }

// abstract class EventsState {
//   bool isBusy = false;
//   List<Events> eventsList = [];
// }


// class EventsInitialState implements EventsState {
//   @override
//   bool isBusy = false;

//   @override
//   List<Events> eventsList = [];
// }
