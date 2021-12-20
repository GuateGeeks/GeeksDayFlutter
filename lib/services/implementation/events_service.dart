import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geeksday/models/events.dart';
import 'package:geeksday/services/events_service.dart';
import 'package:geeksday/services/firestore_path.dart';
import 'package:geeksday/services/firestore_service.dart';


final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

final eventsRef = FirebaseFirestore.instance.collection('events').withConverter<Events>(
  fromFirestore: (snapshots, _) => Events.fromMap(snapshots.data()!, snapshots.id),
  toFirestore: (events, _) => events.toFirebaseMap(),
);


class EventsService extends EventsServiceBase{
  final _firestoreService = FirestoreService.instance;
  final _eventsCollection = FirebaseFirestore.instance.collection('events');


  Future<void> createEvent(Events createEvent) async {
    String createEventPath = FirestorePath.events(createEvent.id);
    await _firestoreService.setData(
      path: createEventPath,
      data: createEvent.toFirebaseMap()
    );
  } 

  Future<Events> createEventImage(Events createEvent, html.Blob file) async {
    String createEventPath = FirestorePath.events(createEvent.id);
    await _firestoreService.storeBlob(path: createEventPath, blob: file);
    await _firestoreService.setData(
      path: createEventPath, 
      data: createEvent.toFirebaseMap(), 
    );

    return Events.fromMap(createEvent.toFirebaseMap(), createEvent.id);
  }

  @override 
  Future<void> updateEvent(Events event) async {
    final ref = eventsRef.doc(event.id);
    await ref.set(event, SetOptions(merge: true));
  }

  @override
  Future<List<Events>> getEventsList() async {
    var _feedlist = <Events>[];
    return eventsRef.get().then((value) {
      value.docs.forEach((element) {
        _feedlist.add(element.data());
      });
      return _feedlist;
    });
  }

  @override
  Future<String> getImageURL(String uid) {
    return _firestoreService.getDownloadURL(FirestorePath.events(uid));
  }
  
}