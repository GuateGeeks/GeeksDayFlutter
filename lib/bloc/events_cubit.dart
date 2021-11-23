
import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/events.dart';
import 'package:geeksday/services/implementation/events_service.dart';
import 'package:random_password_generator/random_password_generator.dart';


class EventsCubit extends Cubit<EventsState>{
  final EventsService _eventsService;
  File? _pickedImage;
  Events? events;
  EventsCubit(this._eventsService) : super(EventsInitialState()){
    getEventsList();
  }

  List<Events> _list = [];

  Future<void> getEventsList() async{
    _list = await _eventsService.getEventsList();
    var _state = EventsInitialState();
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
 

  void addUserToEvent(String eventCode, String userId){

    var a = (state as EventUpdate);

    // _list.forEach((event) { 
    //   if(event.code == eventCode){
    //     List<String> usersList = event.usersList;
    //     event.usersList.forEach((user) { 
    //       if(user != userId){
    //         usersList.add(user);

              



    //       }
    //     });




    //   }
    // });


    // List<String> addEvent = [];
    // addEvent.add(eventCode);
    // Events event = (state as EventUpdate).event.copyWith(
    //   usersList: addEvent
    // );

    // _eventsService.updateEvent(event);

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

abstract class EventsState extends Equatable{
 
  List<Events> listEvents = [];

  @override
  List<Object?> get props => [];
}
class EventsInitialState extends EventsState{


  @override  
  List<Events> listEvents = [];
}
// class EventsInitalState implements EventsState{
//   @override 
//   bool isBusy = false;

//   @override  
//   List<Events> listEvents = [];
// }



class EventUpdate extends EventsState {
  final Events event;

  EventUpdate(this.event);

  @override
  List<Object?> get props => [event];
}