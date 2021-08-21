import 'package:equatable/equatable.dart';

class Quiz extends Equatable {
  List<Question> questions;
  Quiz(this.questions);

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'questions': questions.map((question) => question.toFirebaseMap()),
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> data) {
    var questions = (data['questions'] as List)
        .map((question) => Question.fromMap(question))
        .toList();
    return Quiz(questions);
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

class Question extends Equatable {
  String text;
  List<Answer> answers;

  Question(this.text, this.answers);

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'text': text,
      'answers': answers.map((answer) => answer.toFirebaseMap()),
    };
  }

  factory Question.fromMap(Map<String, dynamic> data) {
    var text = data['text'];
    var answers = (data['answers'] as List)
        .map((answer) => Answer.fromMap(answer))
        .toList();
    return Question(text, answers);
  }

  @override
  List<Object?> get props => [text];
}

class Answer extends Equatable {
  String text;
  bool isCorrect;
  int selectedCounter;
  Answer(this.text, this.isCorrect, this.selectedCounter);

  @override
  List<Object?> get props => [text, isCorrect];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'text': text,
      'isCorrect': isCorrect,
      'selectedCounter': selectedCounter,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> data) {
    var text = data['text'];
    var isCorrect = data['isCorrect'];
    var selectedCounter = data['selectedCounter'];
    return Answer(text, isCorrect, selectedCounter);
  }
}
