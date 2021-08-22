import 'package:equatable/equatable.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/quiz.dart';
import 'package:uuid/uuid.dart';

class Post extends Equatable {
  final String id;
  String text;
  final List<String> likeList;
  int likeCount;
  final int createdAt;
  int? updatedAt;
  final AuthUser user;
  Quiz? quiz;

  Post(
      {required this.id,
      required this.text,
      required this.likeList,
      required this.likeCount,
      required this.createdAt,
      required this.user,
      this.quiz,
      this.updatedAt});

  @override
  List<Object> get props => [id, text, createdAt];

  String get username {
    return this.user.name;
  }

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'text': text,
      'likeList': likeList,
      'likeCount': likeCount,
      'user': user.toFirebaseMap(),
      'createdAt': createdAt,
      'quiz': this.quiz,
    };
  }

  // Return new Post with copied values
  Post copyWith({
    String? id,
    String? text,
    List<String>? likeList,
    int? likeCount,
    int? createdAt,
    AuthUser? user,
    Quiz? quiz,
  }) {
    return Post(
      id: id ?? this.id,
      text: text ?? this.text,
      likeList: likeList ?? this.likeList,
      likeCount: likeCount ?? this.likeCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      user: user ?? this.user,
      quiz: quiz ?? this.quiz,
    );
  }

  factory Post.newPost(String text, AuthUser user) {
    var id = Uuid().v1();
    var createdAt = DateTime.now().millisecondsSinceEpoch;
    var likeList = <String>[];
    var likeCount = 0;
    return Post(
        id: id,
        user: user,
        text: text,
        createdAt: createdAt,
        likeList: likeList,
        likeCount: likeCount);
  }
  factory Post.fromMap(Map<String, dynamic> data, String documentId) {
    var id = documentId;
    var text = data['text'];
    var createdAt = data['createdAt'];
    var likeList = <String>[];
    var likeCount = 0;
    var user = AuthUser.fromMap(data['user']);
    var quiz = data['quiz'] != null ? Quiz.fromMap(data['quiz']) : null;
    if (data["likeList"] != null) {
      final list = data['likeList'];

      if (list is List) {
        data['likeList'].forEach((value) {
          if (value is String) {
            likeList.add(value);
          }
        });
        likeCount = likeList.length;
      }
    }
    return Post(
        id: id,
        user: user,
        text: text,
        createdAt: createdAt,
        likeList: likeList,
        likeCount: likeCount,
        quiz: quiz);
  }
}
