import 'dart:html';

import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/models/quiz.dart';
import 'package:geeksday/services/post_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PostCubit extends Cubit<PostState> {
  final PostServiceBase _postService;
  File? _pickedImage;

  PostCubit(this._postService, Post post) : super(PostInitialState(post));

  void updatePost(String text) {
    state.post.text = text;
    emit(state);
  }

  void addAnswer() {
    var post = state.post.copyWith(text: "Create a Post");
    post.quiz!.questions[0].answers.add(Answer("Respuesta", false, 0));
    emit(PostUpdatedState(post));
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

  List<Answer> getAnswers() {
    return state.post.quiz!.questions[0].answers;
  }

  String getDatePost() {
    var timestamp = state.post.createdAt;
    var now = new DateTime.now();
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var time = '';
    var diff = now.difference(date).inSeconds;
    int seconds = 1;
    int minutes = 60 * seconds;
    int hour = 60 * minutes;
    int days = 24 * hour;

    if (diff < minutes) {
      time = "Justo ahora";
    } else if (diff < 2 * minutes) {
      time = "Hace un minuto";
    } else if (diff < 60 * minutes) {
      time = "Hace ${(diff / minutes).round()} minutos";
    } else if (diff < 2 * hour) {
      time = "Hace una hora";
    } else if (diff < 24 * hour) {
      time = "Hace ${(diff / hour).round()} horas";
    } else if (diff < 48 * hour) {
      time = "Ayer";
    } else {
      time = "Hace ${(diff / days).round()} dias";
    }
    return time;
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

  bool isOwnedBy(String uid) {
    return state.post.user.uid == uid;
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

  int indexOfAnswer(Answer answer) {
    return state.post.quiz!.questions[0].answers.indexOf(answer);
  }

  void updateQuizAnswer(int index, String text) {
    state.post.quiz!.questions[0].answers[index].text = text;
  }

  void toggleAnswerIsCorrect(Answer answer) {
    int index = indexOfAnswer(answer);
    state.post.quiz!.questions[0].answers[index].isCorrect =
        !state.post.quiz!.questions[0].answers[index].isCorrect;
    emit(PostUpdatedState(state.post));
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
