import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Event extends Equatable {
  final String id;
  final String name;
  final String code;
  final int createdAt;
  final List usersList;
  String image;

  Event({
    required this.id,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.usersList,
    required this.image,
  });

  @override
  List<Object> get props => [id, name, code, createdAt, usersList, image];

  Map<String, Object> toFirebaseMap() {
    return <String, Object>{
      'name': name,
      'code': code,
      'createdAt': createdAt,
      'usersList': usersList,
      'image': image,
    };
  }

  Event copyWith({
    String? id,
    String? name,
    String? code,
    int? createdAt,
    List<String>? usersList,
    String? image,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      usersList: usersList ?? this.usersList,
      image: image ?? this.image,
    );
  }

  factory Event.newEvent(String name, String code) {
    var id = Uuid().v1();
    var createdAt = DateTime.now().microsecondsSinceEpoch;
    var usersList = <String>[];
    var image = "";
    return Event(
      id: id,
      name: name,
      code: code,
      createdAt: createdAt,
      usersList: usersList,
      image: image,
    );
  }

  factory Event.fromMap(DocumentSnapshot data, String documentId) {
    var id = documentId;
    var name = data['name'];
    var code = data['code'];
    var createdAt = data['createdAt'];
    var usersList = data['usersList'];
    var image = data['image'];

    return Event(
        id: id,
        name: name,
        code: code,
        createdAt: createdAt,
        usersList: usersList,
        image: image);
  }
}
