import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String uid;
  String name;
  final String email;

  AuthUser(this.uid, this.name, this.email);

  @override
  List<Object> get props => [uid, name, email];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> data) {
    var id = data['uid'];
    var name = data['name'];
    var email = data['email'];
    return AuthUser(id, name, email);
  }
}
