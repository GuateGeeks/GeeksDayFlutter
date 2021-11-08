import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/quiz_records.dart';
import 'package:geeksday/services/quiz_records_service.dart';

class QuizRecordsCubit extends Cubit<QuizRecordsState> {
  final QuizRecordsServiceBase _quizRecordsService;

  QuizRecordsCubit(this._quizRecordsService)
      : super(QuizRecordsInitialState());


  void answeredQuiz(String answer, bool iscorrect, String idpost, String iduser){
    var answeredQuiz = QuizRecords.newQuizRecords(answer, iscorrect, idpost, iduser);
    _quizRecordsService.quizAnswered(answeredQuiz);
  }

  Future<List> getQuizRecordsList(){
    return _quizRecordsService.getQuizRecordsList();
  }
  
}

abstract class QuizRecordsState {
}

class QuizRecordsInitialState extends QuizRecordsState {

}
