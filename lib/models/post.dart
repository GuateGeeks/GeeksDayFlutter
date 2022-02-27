import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
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
  String? imageRoute;

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
      this.imageRoute,
    }
  );

  @override
  List<Object> get props => [id, text, createdAt, likeList, likeCount];

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
      'imageRoute': this.imageRoute,
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
    String? imageRoute,
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
      imageRoute: imageRoute ?? this.imageRoute,
    );
  }

  factory Post.newPost(String text, String idUser, String idEvent) {
    var id = Uuid().v1();
    var createdAt = DateTime.now().millisecondsSinceEpoch;
    var likeList = <String>[];
    var likeCount = 0;
    var commentCount = 0;
    var commentList = <Comment>[];
    var imageRoute = "";
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
        imageRoute: imageRoute,
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
    var imageRoute = data['imageRoute'];
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
        idEvent: idEvent,
        imageRoute: imageRoute,
    );
  }
  factory Post.fromMap1(DocumentSnapshot data, String documentId) {
    var id = documentId;
    var text = data['text'];
    var createdAt = data['createdAt'];
    var likeList = <String>[];
    var likeCount = 0;
    var commentCount = 0;
    var idUser = data["idUser"];
    var quiz = data['quiz'] != null ? Quiz.fromMap(data['quiz']) : null;
    var idEvent = data['idEvent'];
    var imageRoute = data['imageRoute'];
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
        idEvent: idEvent,
        imageRoute: imageRoute,
    );
  }
}

class Comment extends Equatable {
  final String id;
  String text;
  final int createdAt;
  final String idUser;

  Comment({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.idUser,
  });

  factory Comment.newComment(String text, String idUser) {
    var id = Uuid().v1();
    var createdAt = DateTime.now().millisecondsSinceEpoch;
    return Comment(
        id: id, text: text, createdAt: createdAt, idUser: idUser);
  }

  @override
  List<Object?> get props => [id, text, createdAt];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'id': id,
      'text': text,
      'idUser': idUser,
      'createdAt': createdAt,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> data) {
    var id = data['id'];
    var text = data['text'];
    var createdAt = data['createdAt'];
    var idUser = data['idUser'];
    return Comment(
        id: id, text: text, createdAt: createdAt, idUser: idUser);
  }
}
