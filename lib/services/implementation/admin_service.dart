import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/admin_service.dart';

class AdminService extends AdminServiceBase{

   final userRef = FirebaseFirestore.instance
    .collection('users')
    .withConverter<AuthUser>(
      fromFirestore: (snapshots, _) => AuthUser.fromMap(snapshots.data()!),
      toFirestore: (user, _) => user.toFirebaseMap(),
    );
  final postRef =
  FirebaseFirestore.instance.collection('posts').withConverter<Post>(
        fromFirestore: (snapshots, _) =>
            Post.fromMap(snapshots.data()!, snapshots.id),
        toFirestore: (post, _) => post.toFirebaseMap(),
      );


  @override
  Future<List<AuthUser>> higherScoreUserList() {
    var userList = <AuthUser>[];
    return userRef.get().then((value) {
      value.docs.forEach((element) {
        userList.add(element.data());
      });
      return userList;
    });
  }
  
   
  
}