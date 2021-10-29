
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/services/implementation/events_service.dart';

class EventsCubit extends Cubit<EventsState>{
  final EventsService _eventsService;

  EventsCubit(this._eventsService): super(EventsInitialState());

  Future<List> getEventsList(){
    return _eventsService.getEventsList();
  }



}

abstract class EventsState{

}

class EventsInitialState extends EventsState{

}
