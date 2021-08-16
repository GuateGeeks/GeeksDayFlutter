import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Post extends Equatable {
  final String id;
  final String userId;
  String text;
  final List<String> likeList;
  int likeCount;
  final int createdAt;

  Post(
      {required this.id,
      required this.userId,
      required this.text,
      required this.likeList,
      required this.likeCount,
      required this.createdAt});

  @override
  List<Object> get props => [id, text, createdAt];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'text': text,
      'likeList': likeList,
      'likeCount': likeCount,
      'userId': userId,
      'createdAt': createdAt,
    };
  }

  factory Post.newPost(String text, String userId) {
    var id = Uuid().v1();
    var createdAt = DateTime.now().millisecondsSinceEpoch;
    var likeList = <String>[];
    var likeCount = 0;
    return Post(
        id: id,
        userId: userId,
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
    var userId = data['userId'];
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
        userId: userId,
        text: text,
        createdAt: createdAt,
        likeList: likeList,
        likeCount: likeCount);
  }
}
