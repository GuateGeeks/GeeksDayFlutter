import 'dart:html' as html;

import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/firestore_path.dart';
import 'package:geeksday/services/firestore_service.dart';
import 'package:geeksday/services/post_service.dart';
import 'package:geeksday/ui/post/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
final postCollection = firestoreInstance.collection('posts');

class PostService extends PostServiceBase {
  // @override
  // Future<void> createPost(Post post) async {
  //   var element = await postCollection.add(post.toFirebaseMap());
  //   print(element.id);
  //   print(element.get());
  // }

  final _firestoreService = FirestoreService.instance;

  @override
  Future<void> createPost(Post post, html.Blob file) async {
    String postPath = FirestorePath.post(post.id);
    await _firestoreService.setData(
      path: postPath,
      data: post.toFirebaseMap(),
    );
    await _firestoreService.storeFile(path: postPath, blob: file);
  }

  @override
  Future<void> deletePost(String uid) async {
    await postCollection.doc(uid).delete();
  }

  @override
  Future<Post> getPost(String uid) async {
    postCollection.doc(uid);
    return Post(text: "");
  }

  @override
  Future<void> updatePost(Post post) async {
    final ref = postCollection.doc(post.id);
    await ref.set(post.toFirebaseMap(), SetOptions(merge: true));
  }

  @override
  Future<String> getImageURL(String uid) {
    return _firestoreService.getDownloadURL(FirestorePath.post(uid));
  }

  @override
  Stream getPostStream() {
    return FirebaseFirestore.instance.collection('posts').snapshots();
  }

  StreamBuilder getPostBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return ListView(
          children: snapshot.data!.docs.map((post) {
            return PostCard(post: Post(text: ''));
          }).toList(),
        );
      },
    );
  }
}
