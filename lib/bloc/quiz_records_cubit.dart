

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/services/quiz_records_service.dart';

class QuizRecordsCubit extends Cubit<QuizRecordsState> {
  final QuizRecordsServiceBase _quizRecordsService;

  QuizRecordsCubit(this._quizRecordsService)
      : super(QuizRecordsInitialState());


  Future mostrar() async{
    return await _quizRecordsService.getQuizRecordsList();
  }
  
}

abstract class QuizRecordsState {

}

class SortedPost extends QuizRecordsState {}

class QuizRecordsInitialState extends QuizRecordsState {
 
}
