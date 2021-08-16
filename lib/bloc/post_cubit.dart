import 'dart:html';

import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/post_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  final PostServiceBase _postService;
  File? _pickedImage;

  PostCubit(this._postService, Post post) : super(PostInitialState(post));

  Future<void> createNewPost(String text, String userId) async {
    Post newPost = Post.newPost(text, userId);
    _postService.createPost(newPost, _pickedImage!);
  }

  Future<void> createPost(String text) async {
    print(state is PostInitialState);
    Post newPost = (state as PostInitialState).post;
    print(text);
    newPost.text = text;
    print(_postService);
    print(_pickedImage);
    _postService.createPost(newPost, _pickedImage!);
  }

  void setImage(File image) {
    _pickedImage = image;
  }

  Future<String> getImageURL(String uid) {
    return _postService.getImageURL(uid);
  }

  Post getPost() {
    if (state is PostInitialState) {
      return (state as PostInitialState).post;
    }
    return Post.newPost("", "");
  }

  String getLikesCountText() {
    PostInitialState postState = state as PostInitialState;
    if (postState.post.likeCount > 0) {
      return "❤️ ${postState.post.likeCount} Likes";
    }
    return "Se el primero en darle me gusta";
  }

  int getLikesCount() {
    PostInitialState postState = state as PostInitialState;
    return postState.post.likeCount;
  }

  bool isLiked() {
    PostInitialState postState = state as PostInitialState;
    return postState.post.likeCount > 0;
  }

  void toggleLikeToPost(String uid) {
    PostInitialState postState = state as PostInitialState;
    print("toggleLikeToPost");
    if (postState.post.likeList.contains(uid)) {
      print("contains");
      postState.post.likeList.remove(uid);
    } else {
      print("not contains");
      postState.post.likeList.add(uid);
    }
    postState.post.likeCount = postState.post.likeList.length;
    _postService.updatePost(postState.post);
  }
}

abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class NewPostState extends Equatable {}

class PostInitialState extends PostState {
  final Post post;
  PostInitialState(this.post);
}

class PostEmptyState extends PostState {
  PostEmptyState();
}
