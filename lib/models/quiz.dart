import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Quiz extends Equatable {
  final String id = Uuid().v1();
  List<Question> questions;
  bool isanswered;
  Quiz(this.questions, this.isanswered);

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'questions': questions.map((question) => question.toFirebaseMap()),
      'isanswered': isanswered,
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> data) {
    var questions = (data['questions'] as List)
        .map((question) => Question.fromMap(question))
        .toList();
    var isanswered = data['isanswered'];
    return Quiz(questions, isanswered);
  }

  @override
  List<Object?> get props => [id];
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
    var isanswered;
    return Question(text, answers);
  }

  @override
  List<Object?> get props => [text];
}

class Answer extends Equatable {
  final String id = Uuid().v1();
  String text;
  bool isCorrect;
  int selectedCounter;
  Answer(this.text, this.isCorrect, this.selectedCounter);

  @override
  List<Object?> get props => [id, text, isCorrect];

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
