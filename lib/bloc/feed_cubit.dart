import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/post_service.dart';

class FeedCubit extends Cubit<FeedState> {
  final PostServiceBase _postService;

  FeedCubit(this._postService) : super(FeedInitialState()) {
    getPostList();
  }

  /// contain tweet list for home page
  void getPostList() async {
    List<Post> _list = await _postService.getPostList();
    state.postList.addAll(_list);
    emit(state);
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
