import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/models/quiz_records.dart';
import 'package:geeksday/services/admin_service.dart';
import 'package:geeksday/services/auth_service.dart';
import 'package:geeksday/services/post_service.dart';
import 'package:geeksday/services/quiz_records_service.dart';

enum PostFilterOptions {
  MOST_POST,
  MOST_LIKES,
  MOST_COMMENTS,
  MOST_CORRECT_ANSWERS
}

class AdminCubit extends Cubit<AdminState> {
  final AdminServiceBase _adminService;

  final PostServiceBase _postService;
  final QuizRecordsServiceBase _quizRecordsServiceBase;
  final AuthServiceBase _authServiceBase;

  AdminCubit(this._adminService, this._postService, this._authServiceBase,
      this._quizRecordsServiceBase)
      : super(InitialAdminState());

  List<Post> _list = [];

  Map<PostFilterOptions, String?> optionsList() {
    Map<PostFilterOptions, String?> options = {
      PostFilterOptions.MOST_POST: "Más publicaciones",
      PostFilterOptions.MOST_LIKES: "Más me gusta",
      PostFilterOptions.MOST_COMMENTS: "Más Comentarios",
      PostFilterOptions.MOST_CORRECT_ANSWERS: "Más respuestas correctas",
    };
    return options;
  }

  //function to show users with more posts
  Future sortByPostCount(String idEvent) async {
    _list = await _postService.getPostList();
    Map<String, AuthUser> _usersMap = await _adminService.getUserMap();

    Map<dynamic, int> resultMap = {};
    Map<String, AuthUser> resultUsersMap = {};

    for (Post post in _list) {
      if (post.idEvent == idEvent) {
        if (resultMap.containsKey(post.user.uid)) {
          resultMap[post.user.uid] = resultMap[post.user.uid]! + 1;
        } else {
          resultMap[post.user.uid] = 1;
        }
        resultUsersMap[post.user.uid] = _usersMap[post.user.uid]!;
      }
    }
    addMaps(resultMap, resultUsersMap);
  }

  Future sortByLikesCount(String idEvent) async {
    _list = await _postService.getPostList();
    Map<String, AuthUser> _usersMap = await _adminService.getUserMap();
    Map<dynamic, int> resultMap = {};
    Map<String, AuthUser> resultUsersMap = {};

    for (Post post in _list) {
      if (post.idEvent == idEvent) {
        for (var userId in post.likeList) {
          if (resultMap.containsKey(userId)) {
            resultMap[userId] = resultMap[userId]! + 1;
          } else {
            resultMap[userId] = 1;
          }
          resultUsersMap[userId] = _usersMap[userId]!;
        }
      }
    }
    addMaps(resultMap, resultUsersMap);
  }

  Future sortByCommentCount(String idEvent) async {
    _list = await _postService.getPostList();

    Map<String, AuthUser> _usersMap = await _adminService.getUserMap();
    Map<dynamic, int> resultMap = {};
    Map<String, AuthUser> resultUsersMap = {};

    for (Post post in _list) {
      if (post.idEvent == idEvent) {
        for (Comment comment in post.commentList) {
          if (resultMap.containsKey(comment.user.uid)) {
            resultMap[comment.user.uid] = resultMap[comment.user.uid]! + 1;
          } else {
            resultMap[comment.user.uid] = 1;
          }
          resultUsersMap[comment.user.uid] = _usersMap[comment.user.uid]!;
        }
      }
    }
    addMaps(resultMap, resultUsersMap);
  }

  Future sortByAnswersCorrect(String idEvent) async {
    var listQuiz = await _quizRecordsServiceBase.getQuizRecordsList();
    Map<String, AuthUser> _usersMap = await _adminService.getUserMap();
    Map<dynamic, int> resultMap = {};
    Map<String, AuthUser> resultUsersMap = {};

    for (QuizRecords quizRecord in listQuiz) {
      if(quizRecord.iscorrect && quizRecord.idEvent ==idEvent){
        if(resultMap.containsKey(quizRecord.iduser)){
          resultMap[quizRecord.iduser] = resultMap[quizRecord.iduser]! + 1;
        }else{
          resultMap[quizRecord.iduser] = 1;
        }
        resultUsersMap[quizRecord.iduser] = _usersMap[quizRecord.iduser]!;
      }
    }

    addMaps(resultMap, resultUsersMap);
  }

  void addMaps(resultMap, resultUsersMap) {
    var _state = SortedPost();
    _state.postList.addAll(resultMap);
    _state.userList.addAll(resultUsersMap);
    emit(_state);
  }

  void sortPostList(option, idEvent) {
    switch (option) {
      case PostFilterOptions.MOST_POST:
        sortByPostCount(idEvent);
        break;
      case PostFilterOptions.MOST_LIKES:
        sortByLikesCount(idEvent);
        break;
      case PostFilterOptions.MOST_COMMENTS:
        sortByCommentCount(idEvent);
        break;
      case PostFilterOptions.MOST_CORRECT_ANSWERS:
        sortByAnswersCorrect(idEvent);
        break;
      default:
    }
  }
}

abstract class AdminState {
  bool isBusy = false;
  Map postList = {};
  Map userList = {};
  Map optionList = {};
}

class SortedPost extends AdminState {}

class InitialAdminState extends AdminState {
  @override
  bool isBusy = false;

  @override
  Map postList = {};
  Map userList = {};
  Map optionList = {};
}
