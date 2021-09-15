import 'dart:html' as html;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();
  FirebaseStorage get storage => FirebaseStorage.instance;

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await reference.set(data, SetOptions(merge: merge));
  }

  Future<void> storeFile({required String path, required File file}) async {
    await storage.ref().child(path).putFile(file);
  }

  Future<void> storeBlob(
      {required String path, required html.Blob blob}) async {
    await storage.ref().child(path).putBlob(blob);
  }

  Future<String> getDownloadURL(String path) {
    return storage.ref().child(path).getDownloadURL();
  }

  Stream<T> documentStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        builder(snapshot.data() as Map<String, dynamic>, snapshot.id));
  }
}
