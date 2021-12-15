import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geeksday/services/firestore_path.dart';
import 'package:geeksday/services/firestore_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends AuthServiceBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestoreService = FirestoreService.instance;

  final userRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter<AuthUser>(
        fromFirestore: (snapshots, _) => AuthUser.fromMap(snapshots.data()!),
        toFirestore: (user, _) => user.toFirebaseMap(),
      );

  Future<AuthUser?> _userFromFirebase(User? user) async {
    if (user != null) {
      //generate random image
      var random = List.generate(12, (_) => Random().nextInt(100));
      String randomAvatar = random.join();

      var firestoreUser = await _getUser(user.uid);
      if (firestoreUser != null) {
        return firestoreUser;
      }
      String email = user.email != null ? user.email! : "";
      String name = user.displayName != null ? user.displayName! : "";
      String image = randomAvatar;
      bool isadmin = false;
      bool darkmode = false;
      return AuthUser(user.uid, name, email, image, isadmin);
    }
    return null;
  }

  Future<AuthUser?> _getUser(String uid) async {
    var snapshot = await userRef.doc(uid).get();
    return snapshot.data();
  }

  Future<List<AuthUser>> getUsersList(){
    var userList = <AuthUser>[];
    return userRef.get().then((value) {
      value.docs.forEach((element) {
        userList.add(element.data());
      });
      return userList;
    });
  } 




  @override
  Stream<AuthUser?> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().asyncMap(_userFromFirebase);

  @override
  Future<AuthUser?> createUserWithEmailAndPassword(
      String email, String username, String password, String image) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    AuthUser? user = await _userFromFirebase(authResult.user);
    user?.name = username;
    return _createUser(user);
  }

  Future<AuthUser?> _createUser(AuthUser? user) async {
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

  @override
  Future<void> updateUser(AuthUser user) async {
    final ref = userRef.doc(user.uid);
    await ref.set(user, SetOptions(merge: true));
  }
}
