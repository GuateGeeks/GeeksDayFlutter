import 'dart:html';

import 'package:geeksday/models/event.dart';

abstract class EventServiceBase{
  Stream<List<Event>> getEventList(); 
  Future<void> createEvent(Event createEvent, Blob image);
  Future<String> getImageURL(String uid);
  Future<void> eventUpdate(Event event);
}  