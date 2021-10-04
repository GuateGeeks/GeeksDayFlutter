import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/post_service.dart';

class FeedCubit extends Cubit<FeedState> {
  final PostServiceBase _postService;

  FeedCubit(this._postService) : super(FeedInitialState()) {
    getPostList();
  }
  List<Post> _list = [];

  /// contain tweet list for home page
  Future<void> getPostList() async {
    _list = await _postService.getPostList();
    _list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    var _state = FeedInitialState();
    _state.postList.addAll(_list);
    emit(_state);
  }

  void recargar() async {
    _list.clear();
    _list = await _postService.getPostList();
    _list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
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
