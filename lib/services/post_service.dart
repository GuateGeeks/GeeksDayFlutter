import 'dart:html';
import 'package:geeksday/models/post.dart';

abstract class PostServiceBase {
  Future<void> createPost(Post post, Blob image);
  Future<void> createPostText(Post post);
  Future<void> updatePost(Post post);
  Future<void> deletePost(String uid);
  Future<String> getImageURL(String uid);
  Future<List<Post>> getPostList();
}
