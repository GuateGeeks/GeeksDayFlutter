
import 'package:geeksday/models/quiz_records.dart';

abstract class QuizRecordsServiceBase{
  Future<List<QuizRecords>> getQuizRecordsList();
}