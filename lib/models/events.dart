
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Events extends Equatable{
  final String id;
  final String name;
  final String code;
  final int createdAt;
  final List<String> usersList;
  String image;

  Events({
    required this.id,
    required this.name, 
    required this.code,
    required this.createdAt,
    required this.usersList,
    required this.image,
  });

  @override
  List<Object> get props => [id, name, code, createdAt, usersList, image];


  Map<String, Object> toFirebaseMap(){
    return<String, Object>{
      'name': name,
      'code': code,
      'createdAt': createdAt,
      'usersList': usersList,
      'image': image,
    };
  }

  Events copyWith({
    String? id,
    String? name,
    String? code,
    int? createdAt,
    List<String>? usersList,
    String? image,
  }){
    return Events(  
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      createdAt:  DateTime.now().millisecondsSinceEpoch,
      usersList: usersList ?? this.usersList,
      image: image ?? this.image,
    );
  }

  factory Events.newEvents(String name, String code){
    var id = Uuid().v1();
    var createdAt = DateTime.now().microsecondsSinceEpoch;
    var usersList = <String>[];
    var image = "";
    return Events(
      id: id,
      name: name,
      code: code,
      createdAt: createdAt,
      usersList: usersList,
      image: image,
    );
  }

  factory Events.fromMap(Map<String, dynamic> data, String documentId){
    var id = documentId;
    var name = data['name'];
    var code = data['code']; 
    var createdAt = data['createdAt'];
    var usersList = <String>[];
    var image = data['image'];

    if(data["usersList"] != null){
      final list = data["usersList"];
      if(list is List){
        data["usersList"].forEach((user){
          if(user is String){
            usersList.add(user);
          }
        }); 
      } 
    }

    return Events(
      id: id,
      name: name,
      code: code,
      createdAt: createdAt,
      usersList: usersList,
      image: image,
    );
  }
}