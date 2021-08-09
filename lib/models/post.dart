import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Post extends Equatable {
  String id = Uuid().v1();
  final String text;

  Post({String? id, required this.text}) {
    if (id != null) {
      this.id = id;
    }
  }

  @override
  List<Object> get props => [text];

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'text': text,
    };
  }

  factory Post.fromMap(Map<String, dynamic> data, String documentId) {
    String text = data['text'];
    return Post(id: documentId, text: text);
  }
}
