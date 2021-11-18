
import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/models/events.dart';
import 'package:geeksday/services/implementation/auth_service.dart';
import 'package:geeksday/services/implementation/events_service.dart';
import 'package:random_password_generator/random_password_generator.dart';


class EventsCubit extends Cubit<EventsState>{
  final EventsService _eventsService;
  File? _pickedImage;
  EventsCubit(this._eventsService) : super(EventsInitalState());

  Future<void> createEvent(String eventName, String eventCodigo) async {
    var createEvent = Events.newEvents(eventName, eventCodigo);
    if(_pickedImage == null ){
      _eventsService.createEvent(createEvent);
    }else{
      _eventsService.createEventImage(createEvent, _pickedImage!);
    }
  }

  void addUserToEvent(String eventCode){
    List<String> addEvent = [];
    addEvent.add(eventCode);
    Events event = (state as EventsUpdate).event.copyWith(
      usersList: addEvent
    );

    _eventsService.updateEvent(event);

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

  @override
  List<Object?> get props => [];

}

class EventsInitalState extends EventsState{
  
}

class EventsUpdate extends AuthState {
  final Events event;

  EventsUpdate(this.event);

  @override
  List<Object?> get props => [event];
}