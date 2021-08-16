import 'package:geeksday/models/auth_user.dart';

abstract class AuthServiceBase {
  Stream<AuthUser?> get onAuthStateChanged;

  Future<AuthUser?> signInWithEmailAndPassword(String email, String password);

  Future<AuthUser?> createUserWithEmailAndPassword(
      String email, String username, String password);

  Future<AuthUser?> signInWithGoogle();

  Future<AuthUser?> signInWithFacebook();

  Future<AuthUser?> signInAnonymously();

  Future<void> signOut();
}
