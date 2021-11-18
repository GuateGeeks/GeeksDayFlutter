
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/events.dart';
import 'package:geeksday/services/implementation/events_service.dart';

class FeedEventsCubit extends Cubit<FeedEventsState>{
  final EventsService _eventsService;

  FeedEventsCubit(this._eventsService) : super(FeedEventsInitialState()){
    getEventsList();
  }
  List<Events> _list = [];

  Future<void> getEventsList() async{
    _list = await _eventsService.getEventsList();
    var _state = FeedEventsInitialState();
    _state.listEvents.addAll(_list);
    emit(_state);
  }
}

abstract class FeedEventsState{
  bool isBusy = false;
  List<Events> listEvents = [];
}

class FeedEventsInitialState implements FeedEventsState{
  @override 
  bool isBusy = false;

  @override  
  List<Events> listEvents = [];
}