import 'dart:html' as html;

import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/firestore_path.dart';
import 'package:geeksday/services/firestore_service.dart';
import 'package:geeksday/services/post_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

final postRef =
    FirebaseFirestore.instance.collection('posts').withConverter<Post>(
          fromFirestore: (snapshots, _) =>
              Post.fromMap(snapshots.data()!, snapshots.id),
          toFirestore: (post, _) => post.toFirebaseMap(),
        );

class PostService extends PostServiceBase {
  final _firestoreService = FirestoreService.instance;
  final _postCollection = FirebaseFirestore.instance.collection('posts');

  @override
  Future<void> createPost(Post post, html.Blob file) async {
    String postPath = FirestorePath.post(post.id);
    await _firestoreService.storeBlob(path: postPath, blob: file);
    _firestoreService.getDownloadURL(FirestorePath.post(post.id)).then((value){
      post.imageRoute = value.toString();
      _firestoreService.setData(
        path: postPath,
        data: post.toFirebaseMap(),
      );
    });
  }

  Future<void> createPostText(Post post) async{
    String postPath = FirestorePath.post(post.id);
    await _firestoreService.setData(
      path: postPath,
      data: post.toFirebaseMap(),
    );
  }
  //Delete post 
  @override
  Future<void> deletePost(String uid) async {
    await postRef.doc(uid).delete();
    getPostList();
  }
  //Delete post comments
  @override
  Future<void> deleteComment(Post post, String commentid) async{  
    post.commentList.removeWhere((element) => element.id == commentid);
    updatePost(post);
  }

  Future<void> updateIsAnswered(Post post) async {
    final ref = postRef.doc(post.id);
    ref.update({
      'quiz.isanswered': true,
    });

  }

  @override
  Future<void> selectedCounter(Post post, int index, int counter) async{
    int countertoFirebase = counter + 1;
    var editar = post.quiz!.questions[0].answers;
    final ref = postRef.doc(post.id);
    ref.update({
      'quiz.questions.$index.selectedCounter': countertoFirebase,
    });
  }

  @override
  Future<void> updatePost(Post post) async {
    final ref = postRef.doc(post.id);
    await ref.set(post, SetOptions(merge: true));
  }

  @override
  Future<String> getImageURL(String uid) {

    return _firestoreService.getDownloadURL(FirestorePath.post(uid));
  }

  @override
  Future<List<Post>> getPostList() async {
    var _feedlist = <Post>[];
    return postRef.get().then((value) {
      value.docs.forEach((element) {
        _feedlist.add(element.data());
      });
      return _feedlist;
    });
  }

  Stream<List<Post>> listadoPost(){
    final mensajes = FirebaseFirestore.instance.collection("posts");

    return mensajes.orderBy('createdAt', descending: true).snapshots().map(
      (querySnap) => querySnap.docs
        .map((doc) => Post.fromMap1(doc, doc.id))
        .toList(),
    );
  }

  Future<Post> getPostById(String idPost) async{
    var postCollection = _postCollection.doc(idPost);
    return await postCollection.get().then((value) {
        return Post.fromMap1(value, idPost);
    });

  }







}
