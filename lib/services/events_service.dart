import 'dart:html';

import 'package:geeksday/models/events.dart';

abstract class EventsServiceBase{
  Future<List<Events>> getEventsList(); 
  Future<void> createEventImage(Events createEvent, Blob image);
  Future<String> getImageURL(String uid);
  Future<void> updateEvent(Events event);
}  