import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geeksday/models/event.dart';
import 'package:geeksday/services/event_service.dart';
import 'package:geeksday/services/firestore_path.dart';
import 'package:geeksday/services/firestore_service.dart';


final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;


class EventService extends EventServiceBase{
  final _firestoreService = FirestoreService.instance;
  final _eventCollection = FirebaseFirestore.instance.collection('events');

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

  @override
  Stream<List<Event>> getEventList(){
    return _eventCollection.orderBy('createdAt', descending: true).snapshots().map((event) =>
      event.docs.map(
        (doc) {
          return Event.fromMap(doc, doc.id);
        }
      ).toList() 
    );
  } 
  

  Future<void> registerInEvent(String code, String userId) async{
    Map<String, dynamic> usersListMap = Map();
    List listUsers = [];
      _eventCollection.get().then((QuerySnapshot a) {
        a.docs.forEach((element) {
          if(element['code'] == code){
            listUsers = element['usersList'];
            if(!listUsers.contains(userId)){
              listUsers.add(userId);
              usersListMap['usersList'] = listUsers;
              _eventCollection.doc(element.id).set(usersListMap, SetOptions(merge: true));
            }
          }
        });
      });
  }

  @override
  Future<String> getImageURL(String uid) {
    return _firestoreService.getDownloadURL(FirestorePath.event(uid));
  }  
}