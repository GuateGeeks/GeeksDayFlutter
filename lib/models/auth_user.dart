import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String uid;

  const AuthUser(this.uid);

  @override
  List<Object> get props => [uid];
}
