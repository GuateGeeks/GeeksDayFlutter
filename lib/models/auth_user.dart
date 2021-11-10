import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String uid;
  String name;
  String image;
  final String email;
  bool isadmin;
  bool darkmode;
 
  AuthUser(this.uid, this.name, this.email, this.image, this.isadmin, this.darkmode);

  @override
  List<Object> get props => [uid, name, email, image, isadmin, darkmode];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'uid': uid,
      'name': name,
      'email': email,
      'image': image,
      'admin' : isadmin,
      'darkmode': darkmode,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> data) {
    var id = data['uid'];
    var name = data['name'];
    var email = data['email'];
    var image = data['image'];
    var isadmin = data['admin'];
    var darkmode = data['darkmode'];
    return AuthUser(id, name, email, image, isadmin, darkmode);
  }

  AuthUser copyWith({String? name, String? image, bool? darkmode}) {
    return AuthUser(uid, name ?? this.name, email, image ?? this.image, this.isadmin, darkmode ?? this.darkmode);
  }
}
