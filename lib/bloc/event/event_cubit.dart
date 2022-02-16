
import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/event.dart';
import 'package:geeksday/services/event_service.dart';
import 'package:random_password_generator/random_password_generator.dart';

class EventCubit extends Cubit<EventState>{
  final EventServiceBase _eventServiceBase;
  File? uploadImage;
  AuthUser user;

  EventCubit(this._eventServiceBase, this.user) : super(EventInitialState());

  Future<void> getEventList() async {
    List<Event> _listEvent = [];
    final events = this._eventServiceBase.getEventList();
    events.listen((event) {
      event.forEach((element) {
        //if the user is an administrator we show all the events
        if(user.isadmin){
          _listEvent.add(element);
        //if the user is not an administrator, we verify that he is registered in the event
        }else{
          element.usersList.forEach((idUsers) { 
            if(idUsers == user.uid){
              _listEvent.add(element);
            }
          });
        }
      });
        emit(EventLoaded(events: _listEvent));
      _listEvent = [];
      
    },
      onDone: (){},
    );
  }

  Future<void> createEvent(String name, String code) async {
    var createEvent = Event.newEvent(name, code);

    emit(AddingEvent());
    _eventServiceBase.createEvent(createEvent, uploadImage!);
    emit(EventAdded());

  }

  Future<void> registerInEvent() async{
    final events = this._eventServiceBase.getEventList();
    events.listen((event) {
      event.forEach((element) {
        if(element.code == "dgaFkV"){
          element.usersList.add("Este es el agregado");
          updateEvent(element);
        }
      },);
    }, onDone: (){
      print("Se detuvo");
    });
          emit(EventAdded());
  }

  Future<void> updateEvent(Event event) async{
    emit(AddingEvent());
    _eventServiceBase.eventUpdate(event);
  }



  void setImage(File? image) { 
    uploadImage = image;
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


abstract class EventState{}

class EventInitialState extends EventState{}

class EventLoading extends EventState{}

class EventLoaded extends EventState{
  final List<Event> events;
  EventLoaded({required this.events});
}

class AddingEvent extends EventState {}

class EventAdded extends EventState {}


//   List<Event> _list = [];

//   // Future<void> createEvent(String eventName, String eventCodigo) async {
//   //   var createEvent = Event.newEvent(eventName, eventCodigo);
//   //   emit(AddingEvent());

    
//   //   _EventService.createEventImage(createEvent, _pickedImage!).then((event){
//   //     _showEventCubit.addEvent(event);
//   //     emit(EventAdded());
//   //   });

//   // }
 

//   void addUserToEvent(String eventCode, String userId){
//     _list.forEach((event) { 
//       if(event.code == eventCode){
//         if(!event.usersList.contains(userId)){
//           event.usersList.add(userId);
//          _EventService.updateEvent(event).then((value) {
//           emit(EventUpdate(event));
//          }); 
//         }
//       }
//     });
//   }


  


// }

