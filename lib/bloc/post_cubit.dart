import 'dart:html';

import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/models/quiz.dart';
import 'package:geeksday/services/post_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  final PostServiceBase _postService;
  File? _pickedImage;

  PostCubit(this._postService, Post post) : super(PostInitialState(post));

  void updatePost(String text) {
    state.post.text = text;
    emit(state);
  }

  void unsetQuiz() {
    var post = state.post.copyWith(text: "Create a Post");
    post.quiz = null;
    emit(PostUpdatedState(post));
  }

  void setQuiz(Quiz? quiz) {
    var post = state.post.copyWith(text: "Create a Quiz", quiz: quiz);
    emit(PostUpdatedState(post));
  }

  Future<void> createPost(String text) async {
    Post newPost = state.post;
    newPost.text = text;
    _postService.createPost(newPost, _pickedImage!);
  }

  void setImage(File image) {
    _pickedImage = image;
  }

  Future<String> getImageURL(String uid) {
    return _postService.getImageURL(uid);
  }

  Post? getPost() {
    return state.post;
  }

  String getLikesCountText() {
    if (state.post.likeCount > 0) {
      return "❤️ ${state.post.likeCount} Likes";
    }
    return "Se el primero en darle me gusta";
  }

  int getLikesCount() {
    return state.post.likeCount;
  }

  bool isLiked() {
    return state.post.likeCount > 0;
  }

  bool likedByMe(String uid) {
    return state.post.likeList.contains(uid);
  }

  void toggleLikeToPost(String uid) {
    if (state.post.likeList.contains(uid)) {
      state.post.likeList.remove(uid);
    } else {
      state.post.likeList.add(uid);
    }
    state.post.likeCount = state.post.likeList.length;
    _postService.updatePost(state.post);
  }

  bool isQuiz() {
    return state.post.quiz != null && state.post.quiz!.questions.isNotEmpty;
  }
}

abstract class PostState extends Equatable {
  final Post post;
  PostState(this.post);
  @override
  List<Object?> get props => [];
}

class PostInitialState extends PostState {
  PostInitialState(Post post) : super(post);
}

class PostUpdatedState extends PostState {
  int updatedAt = DateTime.now().millisecondsSinceEpoch;
  PostUpdatedState(Post post) : super(post);
  @override
  List<Object?> get props => [updatedAt];
}

class QuizPostState extends PostUpdatedState {
  Quiz? quiz;
  QuizPostState(Post post) : super(post);
}

abstract class NewPostState extends Equatable {}
