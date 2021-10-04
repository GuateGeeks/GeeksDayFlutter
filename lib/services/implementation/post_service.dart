import 'dart:html' as html;

import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/firestore_path.dart';
import 'package:geeksday/services/firestore_service.dart';
import 'package:geeksday/services/post_service.dart';
import 'package:geeksday/ui/post/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    await _firestoreService.setData(
      path: postPath,
      data: post.toFirebaseMap(),
    );
    await _firestoreService.storeBlob(path: postPath, blob: file);
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
  }
  //Delete post comments
  @override
  Future<void> deleteComment(Post post, String commentid) async{
    var commentListid = post.commentList.map((e) => e.id);
    for(final commentItem in commentListid){
      if(commentItem == commentid){
        postRef.doc(post.id).update({"commentList": FieldValue.delete()});
      }
    }
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
}
