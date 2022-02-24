import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/post_service.dart';

class FeedCubit extends Cubit<FeedState> {
  final PostServiceBase _postService;
  
  final String idEvent;
  File? _pickedImage;

  FeedCubit(this._postService, this.idEvent) : super(FeedInitialState());

  Future<void> getPostList() async {
    List<Post> _listPost = [];
    final posts = _postService.listadoPost();
    posts.listen(
      (post) {
        post.forEach((element) {
          if (element.idEvent == idEvent) {
            _listPost.add(element);
          }
        });
        emit(PostLoaded(post: _listPost));
        _listPost = [];
      },
      onDone: () {},
    );
  }

  //create post or quiz
  Future<void> createPost(String text, image, idUser) async {
    var createPost = Post.newPost(text, idUser, idEvent);

    if (image == null) {
      emit(AddingPost());
      _postService.createPostText(createPost);
      emit(PostAdded());
    } else {
      emit(AddingPost());
      _postService.createPost(createPost, image);
      emit(PostAdded());
    }
  }

  void toggleLikeToPost(Post post, String uid) {
    if(post.likeList.contains(uid)){
      post.likeList.remove(uid);
    }else{
      post.likeList.add(uid);
    }
    post.likeCount = post.likeList.length;
    updatePost(post);
  }

  String getLikesCountText(Post post) {
    return post.likeCount.toString();
  }

  bool likedByMe(Post post, String uid) {
    return post.likeList.contains(uid);
  }

  void makeComment(Post post,String idUser, String text) {
    var comment = Comment.newComment(text, idUser);
    post.commentList.add(comment);
    post.commentCount = post.commentList.length;
    _postService.updatePost(post);
  }

  String countComments(Post post) {
    return post.commentCount.toString();
  }


  /*----------------------------------Quiz---------------------------------------*/



















  updatePost(Post post){
    _postService.updatePost(post);
  }



  //function to display image in preview
  void setImage(File? image) {
    _pickedImage = image;
  }
}

abstract class FeedState {
  bool isBusy = false;
  List<Post> postList = [];
}

class FeedInitialState extends FeedState {}

class PostLoading extends FeedState {}

class AddingPost extends FeedState {}

class PostAdded extends FeedState {}

class PostLoaded extends FeedState {
  final List<Post> post;
  PostLoaded({required this.post});
}

