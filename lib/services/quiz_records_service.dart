
import 'package:geeksday/models/quiz_records.dart';

abstract class QuizRecordsServiceBase{
  Future<void> quizAnswered(QuizRecords quizanswered);
  Future<List<QuizRecords>> getQuizRecordsList();
}