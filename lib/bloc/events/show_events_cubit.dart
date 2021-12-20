
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/events.dart';
import 'package:geeksday/services/events_service.dart';

class ShowEventsCubit extends Cubit<ShowEventsState>{
  ShowEventsCubit(this._eventsServiceBase) : super(ShowEventsInitialState());

  final EventsServiceBase _eventsServiceBase;

  Future getEventsList() async {
    _eventsServiceBase.getEventsList().then((event) {
      emit(EventsLoaded(event: event));
    });
  }

  Future<String> getImageURL(String uid) {
    return _eventsServiceBase.getImageURL(uid);
  }

  void addEvents(event){
    final currectState = state;
    if(currectState is EventsLoaded){
      final eventList = currectState.event;
      eventList.add(event);
      emit(EventsLoaded(event: eventList));
    }
  }
}


abstract class ShowEventsState{}

class ShowEventsInitialState extends ShowEventsState{}

class EventsLoading extends ShowEventsState{}

class EventsLoaded extends ShowEventsState{
  final List<Events> event;
  EventsLoaded({required this.event});
}
