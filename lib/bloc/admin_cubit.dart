import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/admin_service.dart';
import 'package:geeksday/services/auth_service.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:geeksday/services/post_service.dart';
import 'package:geeksday/ui/post/post_list.dart';

enum PostFilterOptions {
  MOST_POST,
  MOST_LIKES,
  MOST_COMMENTS,
}

class AdminCubit extends Cubit<AdminState> {
  final AdminServiceBase _adminService;

  final PostServiceBase _postService;
  final AuthServiceBase _authServiceBase;

  AdminCubit(this._adminService, this._postService, this._authServiceBase)
      : super(InitialAdminState());

  List<Post> _list = [];
  List<AuthUser> _listUsers = [];
  Map<dynamic, int> mapa = {};

  Future<void> userList(Map mapa) async {
    var userList = await _adminService.higherScoreUserList();
    for (var user in userList) {
      if (mapa.containsKey(user.uid)) {
        _listUsers.add(user);
      }
    }

    var _state = SortedPost();
    emit(_state);
  }

  Future sortByPostCount() async {
    _list = await _postService.getPostList();

    for (Post post in _list) {
      if (mapa.containsKey(post.user.uid)) {
        mapa[post.user.uid] = mapa[post.user.uid]! + 1;
      } else {
        mapa[post.user.uid] = 1;
      }
    }
    var _state = SortedPost();
    _state.postList.addAll(mapa);
    emit(_state);
    mapa = {};
  }

  Future sortByLikesCount() async {
    _list = await _postService.getPostList();

    for (Post post in _list) {
      for (var userId in post.likeList) {
        if (mapa.containsKey(userId)) {
          mapa[userId] = mapa[userId]! + 1;
        } else {
          mapa[userId] = 1;
        }
      }
    }
    var _state = SortedPost();
    _state.postList.addAll(mapa);
    emit(_state);

    mapa = {};
  }

  Future sortByCommentCount() async {
    _list = await _postService.getPostList();
    Map<String, AuthUser> _usersMap = await _adminService.getUserMap();
    Map<dynamic, int> resultMap = {};
    Map<String, AuthUser> resultUsersMap = {};
    for (Post post in _list) {
      for (Comment comment in post.commentList) {
        if (resultMap.containsKey(comment.user.uid)) {
          resultMap[comment.user.uid] = resultMap[comment.user.uid]! + 1;
        } else {
          resultMap[comment.user.uid] = 1;
        }
        resultUsersMap[comment.user.uid] = _usersMap[comment.user.uid]!;
      }
    }
    var _state = SortedPost();
    _state.postList.addAll(resultMap);
    _state.userList.addAll(resultUsersMap);

    emit(_state);
    mapa = {};
  }

  void sortPostList(PostFilterOptions? option) {
    switch (option) {
      case PostFilterOptions.MOST_POST:
        sortByPostCount();
        break;
      case PostFilterOptions.MOST_LIKES:
        sortByLikesCount();
        break;
      case PostFilterOptions.MOST_COMMENTS:
        sortByCommentCount();
        break;
      default:
    }
  }
}

abstract class AdminState {
  bool isBusy = false;
  Map postList = {};
  Map userList = {};
}

class SortedPost extends AdminState {}

class InitialAdminState extends AdminState {
  @override
  bool isBusy = false;

  @override
  Map postList = {};
  Map userList = {};
}
