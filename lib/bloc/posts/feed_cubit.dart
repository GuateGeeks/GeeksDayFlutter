import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/post_service.dart';

class FeedCubit extends Cubit<FeedState> {
  final PostServiceBase _postService;
  final String idEvent;

  FeedCubit(this._postService, this.idEvent) : super(FeedInitialState()) {
    getPostList();
  }
  List<Post> _list = [];

  /// contain tweet list for home page
  Future<void> getPostList() async {
    List<Post> _listPost = [];
    _postService.getPostList().then((posts) {
      posts.forEach((post) {
        if(post.idEvent == idEvent){
          _listPost.add(post);
        }
      });
      emit(PostLoaded(post: _listPost));
    });
  }
 
}

abstract class FeedState {
  bool isBusy = false;
  List<Post> postList = [];
} 

class FeedInitialState extends FeedState{}

class PostLoading extends FeedState{}

class PostLoaded extends FeedState{
  final List<Post> post;
  PostLoaded({required this.post});
}


