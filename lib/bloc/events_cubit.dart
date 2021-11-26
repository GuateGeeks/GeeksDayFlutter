
import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/events.dart';
import 'package:geeksday/services/implementation/events_service.dart';
import 'package:random_password_generator/random_password_generator.dart';


class EventsCubit extends Cubit<EventsState>{
  final EventsService _eventsService;
  File? _pickedImage;
  AuthUser user;
  EventsCubit(this._eventsService, this.user) : super(EventsInitialState()){
    getEventsList();
  }

  List<Events> _list = [];

  Future<void> getEventsList() async{
    _list = await _eventsService.getEventsList();
    if(user.isadmin){
      var _state = EventsInitialState();
      _state.listEvents.addAll(_list);
      emit(_state);
    }else{
      List<Events> events = [];
      _list.forEach((event) { 
        if(event.usersList.contains(user.uid)){
          events.add(event);
        }
      });
      var _state = EventsInitialState();
      _state.listEvents.addAll(events);
      emit(_state);
    }
  }

  Future<void> createEvent(String eventName, String eventCodigo) async {
    var createEvent = Events.newEvents(eventName, eventCodigo);
    if(_pickedImage == null ){
      _eventsService.createEvent(createEvent);
    }else{
      _eventsService.createEventImage(createEvent, _pickedImage!);
    }
  }

  String getEventName(String idEvent){
    String eventName = "";
    _list.forEach((event) { 
      if(event.id == idEvent){
        eventName = event.name;
      }
    });
    return eventName;
  }
 

  void addUserToEvent(String eventCode, String userId){
    _list.forEach((event) { 
      if(event.code == eventCode){
        if(!event.usersList.contains(userId)){
          event.usersList.add(userId);
         _eventsService.updateEvent(event).then((value) {
          emit(EventUpdate(event));
         }); 
        }
      }
    });
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
  List<Events> listEventsUser = [];

}
class EventsInitialState extends EventsState{
  @override
  bool isBusy = false;
  @override  
  List<Events> listEvents = []; 
  List<Events> listEventsUser = [];
}

class EventUpdate extends EventsState {
  final Events event;

  EventUpdate(this.event);
}