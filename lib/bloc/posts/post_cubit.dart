import 'dart:html';

import 'package:geeksday/models/post.dart';
import 'package:geeksday/models/quiz.dart';
import 'package:geeksday/services/post_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  final PostServiceBase _postService;
  File? _pickedImage;

  PostCubit(this._postService, Post post) : super(PostInitialState(post));

  /*-----------------------------------------Post General-------------------------------------------*/

  //edit post or quiz
  void updatePost(String text) {
    state.post.text = text;
    emit(state);
  }

  //create post or quiz
  Future<void> createPost(String text) async { 
    Post newPost = state.post;
    newPost.text = text;
    //We check if the publication contains an image and we save it in the database, otherwise only the description of the publication is saved
    if(_pickedImage == null){
      _postService.createPostText(newPost);
      emit(CreatePost(newPost));
    }else{
      _postService.createPost(newPost, _pickedImage!);
    }
  }

  //get the post
  Post? getPost() {
    return state.post;
  }

  //function to show when a post, quiz or comment was made
  String getDatePost(createdAt) {
    var timestamp = createdAt;
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

  //function to display image in preview
  void setImage(File? image) {
    _pickedImage = image;
  }

  //we get the image of the publication from the database
  // Future<String> getImageURL(String uid) {
  //   return _postService.getImageURL(uid);
  // }
  String? getImageUrl(String uid){
    return state.post.imageRoute;
  }

  //function to save the id of the user who likes a post
  void toggleLikeToPost(String uid) {
    //We verify if the user had already liked it, if so, the id of the database is eliminated, otherwise it is added
    if (state.post.likeList.contains(uid)) {
      state.post.likeList.remove(uid);
    } else {
      state.post.likeList.add(uid);
    }
    state.post.likeCount = state.post.likeList.length;
    _postService.updatePost(state.post);
    emit(PostUpdatedState(state.post));
  }

  //show the number of likes of the post
  String getLikesCountText() {
    return "${state.post.likeCount}";
  }

  bool likedByMe(String uid) {
    return state.post.likeList.contains(uid);
  }
  //function to show the options button in posts, this button only appears in posts made by the user
  bool isOwnedBy(String uid) {
    return state.post.idUser == uid;
  }
  //get the id of the post or quiz
  String idPost() {
    return state.post.id;
  }

  String idEvent(){
    return state.post.idEvent;
  }

  //delete post or quiz
  void postDeletion(String uid) {
    _postService.deletePost(uid);
    emit(PostUpdatedState(state.post));
  }
  //this function shows in the modal the option to create the post
  void unsetQuiz() {
    var post = state.post.copyWith(text: "Create a Post");
    post.quiz = null;
    emit(PostUpdatedState(post));
  }

  /*---------------------------------------Quiz----------------------------------------*/

  //add quiz answers
  void addAnswer() {
    var post = state.post.copyWith(text: "Create a Post");
    post.quiz!.questions[0].answers.add(Answer("Respuesta", false, 0));
    emit(PostUpdatedState(post));
  }
  //this function shows in the modal the option to  create a quiz
  void setQuiz(Quiz? quiz) {
    var post = state.post.copyWith(text: "Create a Quiz", quiz: quiz);
    emit(PostUpdatedState(post));
  }

  List<Answer> getAnswers() {
    return state.post.quiz!.questions[0].answers;
  }

  void makeComment(String idUser, String text) {
    var comment = Comment.newComment(text, idUser);
    state.post.commentList.add(comment);
    state.post.commentCount = state.post.commentList.length;
    _postService.updatePost(state.post);
    emit(PostUpdatedState(state.post));
  }

  String countComments(){
    return "${state.post.commentCount}";
  }

  void commentDeletion(String commentid){
    _postService.deleteComment(state.post, commentid);
    emit(PostUpdatedState(state.post));
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

  //function to check if the quiz was answered, if so we return true otherwise false
  bool isAnswered(String userId){
    bool userResponded = false;
    var usersResponded = state.post.quiz!.usersresponded;
    usersResponded.forEach((user) { 
      if(user == userId){
        userResponded = true;
      }
    });
    return userResponded;
  }

  void usersResponded(String userId){
    state.post.quiz!.usersresponded.add(userId);
    _postService.updatePost(state.post);
    emit(PostUpdatedState(state.post));
  }

  int porcentage(int total, selectedCounter){
    if(total > 0){
      return ((selectedCounter.toDouble() / total) * 100).round();
    }else{
      return 0;
    }
  }


  void toggleAnswerIsCorrect(Answer answer) {
    int index = indexOfAnswer(answer);
    state.post.quiz!.questions[0].answers[index].isCorrect =
        !state.post.quiz!.questions[0].answers[index].isCorrect;
    _postService.updatePost(state.post);
    emit(PostUpdatedState(state.post));
  }

  void selectCounter(Answer answer){
    int index = indexOfAnswer(answer);
    state.post.quiz!.questions[0].answers[index].selectedCounter = 
      state.post.quiz!.questions[0].answers[index].selectedCounter + 1;
    _postService.updatePost(state.post);
    emit(PostUpdatedState(state.post));
  }



  int totalresponses(PostCubit state){
    var answers = state.getAnswers();
    int total = 0;
    answers.forEach((element) { 
      total += element.selectedCounter;
    });
    return total;
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

class CreatePost extends PostState{
  CreatePost(Post post) : super(post);
}

class QuizPostState extends PostUpdatedState {
  Quiz? quiz;
  QuizPostState(Post post) : super(post);
}

