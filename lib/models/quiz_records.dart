import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:uuid/uuid.dart';

class QuizRecords{
  final String id;
  final String answer;
  final bool iscorrect;
  final Post post;
  final AuthUser user;

  QuizRecords({
    required this.id,
    required this.answer,
    required this.iscorrect,
    required this.post,
    required this.user,
  });


  factory QuizRecords.newQuizRecords(String answer, bool iscorrect, Post post,  AuthUser user,){
    var id = Uuid().v1();
    return QuizRecords(id: id, answer: answer, iscorrect: iscorrect, post: post, user: user,);
  }

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'answer': answer,
      'iscorrect': iscorrect,
      'post': post.toFirebaseMap(),
      'user': user.toFirebaseMap(),
    };
  }

  factory QuizRecords.fromMap(Map<String, dynamic> data){
    var id = data['id'];
    var answer = data['answer'];
    var iscorrect = data['iscorrect'];
    var post = Post.fromMap(data['post'], "");
    var user = AuthUser.fromMap(data['user']);
    return QuizRecords(id: id, answer: answer, iscorrect: iscorrect, post: post, user: user);
  }
}