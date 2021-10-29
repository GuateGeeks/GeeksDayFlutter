

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geeksday/models/events.dart';
import 'package:geeksday/services/events_service.dart';
import 'package:geeksday/services/firestore_service.dart';


final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

final eventsRef = FirebaseFirestore.instance.collection('events').withConverter<Events>(
  fromFirestore: (snapshots, _) => Events.fromMap(snapshots.data()!, snapshots.id),
  toFirestore: (events, _) => events.toFirebaseMap(),
);


class EventsService extends EventsServiceBase{
  final _firestoreService = FirestoreService.instance;
  final _eventsCollection = FirebaseFirestore.instance.collection('events');

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
  
}