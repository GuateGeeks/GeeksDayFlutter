
import 'package:uuid/uuid.dart';

class Events{
  final String id;
  final String name;
  final String code;
  final int createAt;

  Events({
    required this.id,
    required this.name,
    required this.code,
    required this.createAt
  });


  Map<String, Object> toFirebaseMap(){
    return<String, Object>{
      'name': name,
      'code': code,
      'createAt': createAt
    };
  }

  Events copyWith({
    String? id,
    String? name,
    String? code,
    int? createAt
  }){
    return Events(  
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      createAt:  DateTime.now().millisecondsSinceEpoch,
    );
  }

  factory Events.newEvents(String name, String code){
    var id = Uuid().v1();
    var createAt = DateTime.now().microsecondsSinceEpoch;
    return Events(
      id: id,
      name: name,
      code: code,
      createAt: createAt,
    );
  }

  factory Events.fromMap(Map<String, dynamic> data, String documentId){
    var id = documentId;
    var name = data['name'];
    var code = data['code'];
    var createAt = data['createAt'];

    return Events(
      id: id,
      name: name,
      code: code,
      createAt: createAt,
    );
  }


}