import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String uid;
  String name;
  String image;
  final String email;
  bool isadmin;
 
  AuthUser(this.uid, this.name, this.email, this.image, this.isadmin);

  @override
  List<Object> get props => [uid, name, email, image, isadmin];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'uid': uid,
      'name': name,
      'email': email,
      'image': image,
      'admin' : isadmin,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> data) {
    var id = data['uid'];
    var name = data['name'];
    var email = data['email'];
    var image = data['image'];
    var isadmin = data['admin'];
    return AuthUser(id, name, email, image, isadmin);
  }

  AuthUser copyWith({String? name, String? image}) {
    return AuthUser(uid, name ?? this.name, email, image ?? this.image, this.isadmin);
  }
}
