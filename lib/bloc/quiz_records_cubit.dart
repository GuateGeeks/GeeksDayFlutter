import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/quiz_records.dart';
import 'package:geeksday/services/quiz_records_service.dart';

class QuizRecordsCubit extends Cubit<QuizRecordsState> {
  final QuizRecordsServiceBase _quizRecordsService;

  QuizRecordsCubit(this._quizRecordsService)
      : super(QuizRecordsInitialState());


  void answeredQuiz(String answer, bool iscorrect, String idpost, String iduser){
    var a = QuizRecords.newQuizRecords(answer, iscorrect, idpost, iduser);
    _quizRecordsService.quizAnswered(a);
    
  }

  mostrar(){
    print("Hila mundo");
  }
 
  
}

abstract class QuizRecordsState {

}

class SortedPost extends QuizRecordsState {
}

class QuizRecordsInitialState extends QuizRecordsState {

}
