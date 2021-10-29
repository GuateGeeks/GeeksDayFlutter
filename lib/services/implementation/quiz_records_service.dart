import 'package:geeksday/models/quiz_records.dart';
import 'package:geeksday/services/firestore_path.dart';
import 'package:geeksday/services/firestore_service.dart';
import 'package:geeksday/services/quiz_records_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> quizAnswered(QuizRecords quizRecords) async {
    String quizAnsweredPath = FirestorePath.quizRecords(quizRecords.id);
    await _firestoreService.setData(
      path: quizAnsweredPath,
      data: quizRecords.toFirebaseMap()
    );
  }

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
