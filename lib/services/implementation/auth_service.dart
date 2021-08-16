import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geeksday/services/firestore_path.dart';
import 'package:geeksday/services/firestore_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends AuthServiceBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestoreService = FirestoreService.instance;

  AuthUser? _userFromFirebase(User? user) =>
      user == null ? null : AuthUser(user.uid, user.displayName, user.email);

  @override
  Stream<AuthUser?> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().asyncMap(_userFromFirebase);

  @override
  Future<AuthUser?> createUserWithEmailAndPassword(
      String email, String username, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    AuthUser? user = _userFromFirebase(authResult.user);
    print(username);
    user?.name = username;
    return _createUser(user);
  }

  Future<AuthUser?> _createUser(AuthUser? user) async {
    print(user?.toFirebaseMap());
    if (user != null) {
      String userPath = FirestorePath.user(user.uid);
      await _firestoreService.setData(
        path: userPath,
        data: user.toFirebaseMap(),
      );
    }
    return user;
  }

  @override
  Future<AuthUser?> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AuthUser?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AuthUser?> signInWithFacebook() async {
    // final result = await FacebookAuth.instance.login();

    // final facebookAuthCredential =
    //     FacebookAuthProvider.credential(result.accessToken!.token);

    // final authResult = await FirebaseAuth.instance
    //     .signInWithCredential(facebookAuthCredential);
    // return _userFromFirebase(authResult.user);
  }

  @override
  Future<AuthUser?> signInAnonymously() async {
    final user = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(user.user);
  }

  @override
  Future<void> signOut() async {
    // final googleSignIn = GoogleSignIn();
    // await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
