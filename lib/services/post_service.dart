import 'dart:html';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/models/quiz.dart';

abstract class PostServiceBase {
  Future<void> createPost(Post post, Blob image);
  Future<void> createPostText(Post post);
  Future<void> updatePost(Post post);
  Future<void> deletePost(String uid);
  Future<void> deleteComment(Post post, String commentid);
  Future<String> getImageURL(String uid);
  Future<List<Post>> getPostList();
  Future<void> updateIsAnswered(Post post);
  Future<void> selectedCounter(Post post, int answer, int counter);
}
