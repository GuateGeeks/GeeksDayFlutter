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
    //list to save all the posts that contain the id of the event that is received by parameter
    List<Post> _listPosts = [];
    //We bring all the posts
    _list = await _postService.getPostList();
    //we go through all the posts and compare if there is a post with the event id that we have as a parameter
    _list.forEach((post) {
      if(post.idEvent == idEvent){
        _listPosts.add(post);
      }
    });
    var _state = FeedInitialState();
    _state.postList.addAll(_listPosts);
    emit(_state);
  }
 
}

abstract class FeedState {
  bool isBusy = false;
  List<Post> postList = [];
}

class FeedInitialState implements FeedState {
  @override
  bool isBusy = false;

  @override
  List<Post> postList = [];
}
