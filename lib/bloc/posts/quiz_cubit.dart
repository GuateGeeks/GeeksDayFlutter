import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/quiz.dart';
import 'package:geeksday/models/quiz_records.dart';
import 'package:geeksday/ui/post/quiz/quiz_form.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitialState());
  List<Answer> _answerList = [];

  bool _quizEnabled = false;
  void setQuizEnable(bool newValue) {
    _quizEnabled = newValue;
    emit(QuizEnabled());
  }

  bool isQuizEnabled() {
    return _quizEnabled;
  }

  get answers => _answerList;

  void addItem() {
    _answerList.add(Answer("", false, 0));
    emit(QuizItemAdded());
  }

  void removeItem(Answer answer) {
    _answerList.remove(answer);
    emit(QuizItemRemoved());
  }
}

abstract class QuizState {
  bool _quizEnabled = false;

  get quizEnabled => _quizEnabled;
}

class QuizInitialState extends QuizState {}

class QuizItemAdded extends QuizState {}

class QuizItemRemoved extends QuizState {
  QuizItemRemoved();
}

class QuizEnabled extends QuizState {}
