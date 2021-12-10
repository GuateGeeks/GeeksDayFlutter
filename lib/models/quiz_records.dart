import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class QuizRecords extends Equatable{
  final String id;
  String answer;
  bool iscorrect;
  String idpost;
  String iduser;
  String idEvent;

  QuizRecords({
    required this.id,
    required this.answer,
    required this.iscorrect,
    required this.idpost,
    required this.iduser,
    required this.idEvent,
  });

  @override
  List<Object> get props => [id, answer, iscorrect, idpost, iduser];

  factory QuizRecords.newQuizRecords(String answer, bool iscorrect, String idpost,  String iduser, String idEvent){
    var id = Uuid().v1();
    return QuizRecords(id: id, answer: answer, iscorrect: iscorrect, idpost: idpost, iduser: iduser, idEvent: idEvent);
  }

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'answer': answer,
      'iscorrect': iscorrect,
      'idpost': idpost,
      'iduser': iduser,
      'idEvent': idEvent,
    };
  }

  factory QuizRecords.fromMap(Map<String, dynamic> data){
    var id = data['id'];
    var answer = data['answer'];
    var iscorrect = data['iscorrect'];
    var idpost = data['idpost'];
    var iduser = data['iduser'];
    var idEvent = data['idEvent'];
    return QuizRecords(id: id, answer: answer, iscorrect: iscorrect, idpost: idpost, iduser: iduser, idEvent: idEvent);
  }

  QuizRecords copyWith({
    String? id,
    String? answer,
    bool? iscorrect,
    String? idpost,
    String? iduser,
    String? idEvent,
  }) {
    return QuizRecords(
      id: id ?? this.id,
      answer: answer ?? this.answer,
      iscorrect: iscorrect ?? this.iscorrect,
      idpost: idpost ?? this.idpost,
      iduser: iduser ?? this.iduser,
      idEvent: idEvent ?? this.idEvent,
    );
  }

}