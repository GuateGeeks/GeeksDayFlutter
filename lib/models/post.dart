import 'package:equatable/equatable.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/quiz.dart';
import 'package:uuid/uuid.dart';

class Post extends Equatable {
  final String id;
  String text;
  final List<String> likeList;
  int likeCount;
  int commentCount;
  final int createdAt;
  int? updatedAt;
  final String idUser;
  Quiz? quiz;
  final List<Comment> commentList;
  final String idEvent;

  Post(
      {required this.id,
      required this.text,
      required this.likeList,
      required this.likeCount,
      required this.commentCount,
      required this.createdAt,
      required this.idUser,
      required this.commentList,
      this.quiz,
      this.updatedAt,
      required this.idEvent,
    }
  );

  @override
  List<Object> get props => [id, text, createdAt];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'text': text,
      'likeList': likeList,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'idUser': idUser,
      'createdAt': createdAt,
      'commentList': commentList.map((comment) => comment.toFirebaseMap()),
      'quiz': this.quiz != null ? this.quiz!.toFirebaseMap() : null,
      'idEvent': this.idEvent,
    };
  }

  // Return new Post with copied values
  Post copyWith({
    String? id,
    String? text,
    List<String>? likeList,
    int? likeCount,
    int? commentCount,
    int? createdAt,
    String? idUser,
    List<Comment>? commentList,
    Quiz? quiz,
    String? idEvent,
  }) {
    return Post(
      id: id ?? this.id,
      text: text ?? this.text,
      likeList: likeList ?? this.likeList,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      commentList: commentList ?? this.commentList,
      idUser: idUser ?? this.idUser,
      quiz: quiz ?? this.quiz,
      idEvent: idEvent ?? this.idEvent,
    );
  }

  factory Post.newPost(String text, String idUser, String idEvent) {
    var id = Uuid().v1();
    var createdAt = DateTime.now().millisecondsSinceEpoch;
    var likeList = <String>[];
    var likeCount = 0;
    var commentCount = 0;
    var commentList = <Comment>[];
    return Post(
        id: id,
        idUser: idUser,
        text: text,
        createdAt: createdAt,
        likeList: likeList,
        likeCount: likeCount,
        commentCount: commentCount,
        commentList: commentList,
        idEvent: idEvent,
    );
  }
  factory Post.fromMap(Map<String, dynamic> data, String documentId) {
    var id = documentId;
    var text = data['text'];
    var createdAt = data['createdAt'];
    var likeList = <String>[];
    var likeCount = 0;
    var commentCount = 0;
    var idUser = data["idUser"];
    var quiz = data['quiz'] != null ? Quiz.fromMap(data['quiz']) : null;
    var idEvent = data['idEvent'];
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

    var commentList = <Comment>[];
    if (data["commentList"] != null) {
      commentList = (data['commentList'] as List)
          .map((comment) => Comment.fromMap(comment))
          .toList();
      commentCount = commentList.length;
    }

    return Post(
        id: id,
        idUser: idUser,
        text: text,
        createdAt: createdAt,
        likeList: likeList,
        likeCount: likeCount,
        commentCount: commentCount,
        commentList: commentList,
        quiz: quiz,
        idEvent: idEvent
    );
  }
}

class Comment extends Equatable {
  final String id;
  String text;
  String image;
  final int createdAt;
  final AuthUser user;

  Comment({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.user,
    required this.image,
  });

  factory Comment.newComment(String text, AuthUser user, String image) {
    var id = Uuid().v1();
    var createdAt = DateTime.now().millisecondsSinceEpoch;
    return Comment(
        id: id, text: text, createdAt: createdAt, user: user, image: image);
  }

  @override
  List<Object?> get props => [id, text, createdAt];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'text': text,
      'user': user.toFirebaseMap(),
      'createdAt': createdAt,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> data) {
    var id = data['id'];
    var text = data['text'];
    var createdAt = data['createdAt'];
    var image = data['image'];
    var user = AuthUser.fromMap(data['user']);
    return Comment(
        id: id, text: text, createdAt: createdAt, user: user, image: image);
  }
}
