import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String uid;
  String? name;
  final String? email;

  AuthUser(this.uid, this.name, this.email);

  @override
  List<Object> get props => [uid];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> data, String documentId) {
    var id = documentId;
    var name = data['text'];
    var email = data['createdAt'];
    return AuthUser(id, name, email);
  }
}
