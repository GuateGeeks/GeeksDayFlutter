
import 'package:equatable/equatable.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:uuid/uuid.dart';

class Events extends Equatable{
  final String id;
  final String name;
  final String code;
  final int createAt;
  final List<String> usersList;

  Events({
    required this.id,
    required this.name, 
    required this.code,
    required this.createAt,
    required this.usersList,
  });

  @override
  List<Object> get props => [id, name, code, createAt];


  Map<String, Object> toFirebaseMap(){
    return<String, Object>{
      'name': name,
      'code': code,
      'createAt': createAt,
      'usersList': usersList,
    };
  }

  Events copyWith({
    String? id,
    String? name,
    String? code,
    int? createAt,
    List<String>? usersList,
  }){
    return Events(  
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      createAt:  DateTime.now().millisecondsSinceEpoch,
      usersList: usersList ?? this.usersList,
    );
  }

  factory Events.newEvents(String name, String code){
    var id = Uuid().v1();
    var createAt = DateTime.now().microsecondsSinceEpoch;
    var usersList = <String>[];
    return Events(
      id: id,
      name: name,
      code: code,
      createAt: createAt,
      usersList: usersList,
    );
  }

  factory Events.fromMap(Map<String, dynamic> data, String documentId){
    var id = documentId;
    var name = data['name'];
    var code = data['code'];
    var createAt = data['createAt'];
    var usersList = <String>[];

    return Events(
      id: id,
      name: name,
      code: code,
      createAt: createAt,
      usersList: usersList,
    );
  }
}