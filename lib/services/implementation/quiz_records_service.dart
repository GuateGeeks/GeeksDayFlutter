import 'dart:html' as html;

import 'package:geeksday/models/post.dart';
import 'package:geeksday/models/quiz_records.dart';
import 'package:geeksday/services/firestore_path.dart';
import 'package:geeksday/services/firestore_service.dart';
import 'package:geeksday/services/post_service.dart';
import 'package:geeksday/services/quiz_records_service.dart';
import 'package:geeksday/ui/post/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;



final quizRecordsRef =
    FirebaseFirestore.instance.collection('quiz_records').withConverter<QuizRecords>(
          fromFirestore: (snapshots, _) =>
              QuizRecords.fromMap(snapshots.data()!),
          toFirestore: (quizRecords, _) => quizRecords.toFirebaseMap(),
    );

class QuizRecordsService extends QuizRecordsServiceBase{
  final _firestoreService = FirestoreService.instance;
  final _quizRecordsCollection = FirebaseFirestore.instance.collection('quiz_records');

   @override
  Future<List<QuizRecords>> getQuizRecordsList() async {
    
    var _feedlist = <QuizRecords>[];
    return quizRecordsRef.get().then((value) {
      value.docs.forEach((element) {
        _feedlist.add(element.data());
      });
      return _feedlist;
    });
  }

}
