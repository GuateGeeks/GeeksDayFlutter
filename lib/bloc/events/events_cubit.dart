
import 'dart:async';
import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/events/show_events_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/events.dart';
import 'package:geeksday/services/implementation/events_service.dart';
import 'package:random_password_generator/random_password_generator.dart';


class EventsCubit extends Cubit<EventsState>{
  final EventsService _eventsService;
  File? _pickedImage;
  AuthUser user;
  ShowEventsCubit _showEventsCubit;
  EventsCubit(this._eventsService, this.user, this._showEventsCubit) : super(EventsInitialState()){
    // getEventsList();
  }

  List<Events> _list = [];

  Future<void> createEvent(String eventName, String eventCodigo) async {
    var createEvent = Events.newEvents(eventName, eventCodigo);
    emit(AddingEvent());

    
    _eventsService.createEventImage(createEvent, _pickedImage!).then((event){
      _showEventsCubit.addEvents(event);
      emit(EventAdded());
    });

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

class AddingEvent extends EventsState{}

class EventAdded extends EventsState{}

class EventUpdate extends EventsState {
  final Events event;

  EventUpdate(this.event);
}