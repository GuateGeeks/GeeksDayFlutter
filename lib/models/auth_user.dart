import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String uid;
  String name;
  String image;
  final String email;

  AuthUser(this.uid, this.name, this.email, this.image);

  @override
  List<Object> get props => [uid, name, email, image];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'uid': uid,
      'name': name,
      'email': email,
      'image': image,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> data) {
    var id = data['uid'];
    var name = data['name'];
    var email = data['email'];
    var image = data['image'];
    return AuthUser(id, name, email, image);
  }
}
