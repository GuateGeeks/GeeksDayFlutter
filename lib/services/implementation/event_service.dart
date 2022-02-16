import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geeksday/models/event.dart';
import 'package:geeksday/services/event_service.dart';
import 'package:geeksday/services/firestore_path.dart';
import 'package:geeksday/services/firestore_service.dart';


final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;


class EventService extends EventServiceBase{
  final _firestoreService = FirestoreService.instance;
  final _EventCollection = FirebaseFirestore.instance.collection('events');

  Future<void> createEvent(Event eventData, html.Blob file) async {
    String eventPath = FirestorePath.event(eventData.id);
    await _firestoreService.storeBlob(path: eventPath, blob: file);
    _firestoreService.getDownloadURL(FirestorePath.event(eventData.id)).then((value) {
      eventData.image = value.toString();
      _firestoreService.setData(
        path: eventPath,
        data: eventData.toFirebaseMap(),
      );
    });
  }
  // Future<Event> createEventImage(Event createEvent, html.Blob file) async {
  //   String createEventPath = FirestorePath.Event(createEvent.id);
  //   await _firestoreService.storeBlob(path: createEventPath, blob: file);
  //   _firestoreService.getDownloadURL(FirestorePath.Event(createEvent.id)).then((image){
  //     createEvent.image = image.toString();
  //     _firestoreService.setData(
  //       path: createEventPath, 
  //       data: createEvent.toFirebaseMap(), 
  //     );
  //   });

  //   // return Event.fromMap(createEvent.toFirebaseMap(), createEvent.id);
  // }

  @override
  Stream<List<Event>> getEventList(){
    final events = FirebaseFirestore.instance.collection('events');

    return events.orderBy('createdAt', descending: true).snapshots().map((event) =>
      event.docs.map(
        (doc) {
          return Event.fromMap(doc, doc.id);
        }
      ).toList()
    );
  } 

  Future<void> eventUpdate(Event eventUpdate) async{
    final event = FirebaseFirestore.instance.collection('events').doc(eventUpdate.id);
    await event.set(eventUpdate.toFirebaseMap(), SetOptions(merge: true));
    getEventList();
  }


  // @override 
  // Future<void> updateEvent(Event event) async {
  //   final ref = EventRef.doc(event.id);
  //   await ref.set(event, SetOptions(merge: true));
  // }

  // @override
  // Future<List<Event>> getEventList() async {
  //   var _feedlist = <Event>[];
  //   return EventRef.get().then((value) {
  //     value.docs.forEach((element) {
  //       _feedlist.add(element.data());
  //     });
  //     return _feedlist;
  //   });
  // }

  @override
  Future<String> getImageURL(String uid) {
    return _firestoreService.getDownloadURL(FirestorePath.event(uid));
  }  
}