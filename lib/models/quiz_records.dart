import 'package:equatable/equatable.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:uuid/uuid.dart';

class QuizRecords{
  final String id;
  String answer;
  bool iscorrect;
  String idpost;
  String iduser;
  bool answered; 

  QuizRecords({
    required this.id,
    required this.answer,
    required this.iscorrect,
    required this.idpost,
    required this.iduser,
    required this.answered,
  });

  @override
  List<Object> get props => [id, answer, iscorrect];

  factory QuizRecords.newQuizRecords(String answer, bool iscorrect, String idpost,  String iduser){
    var id = Uuid().v1();
    var answered = false;
    return QuizRecords(id: id, answer: answer, iscorrect: iscorrect, idpost: idpost, iduser: iduser, answered: answered);
  }

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'answer': answer,
      'iscorrect': iscorrect,
      'idpost': idpost,
      'iduser': iduser,
      'answered': answered,
    };
  }

  factory QuizRecords.fromMap(Map<String, dynamic> data){
    var id = data['id'];
    var answer = data['answer'];
    var iscorrect = data['iscorrect'];
    var idpost = data['idpost'];
    var iduser = data['iduser'];
    var answered = data['answered'];
    return QuizRecords(id: id, answer: answer, iscorrect: iscorrect, idpost: idpost, iduser: iduser, answered: answered);
  }
}