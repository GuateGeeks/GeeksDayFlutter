
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/admin_service.dart';
import 'package:geeksday/services/auth_service.dart';
import 'package:geeksday/services/post_service.dart';


  enum PostFilterOptions{
    BY_CREATION_DATE, BY_LIKES, 
  }

class AdminCubit extends Cubit<AdminState>{
  final AdminServiceBase _adminService;

  final PostServiceBase _postService;
  final AuthServiceBase _authServiceBase;

  AdminCubit(this._adminService, this._postService, this._authServiceBase) : super(InitialAdminState());

  List<Post> _list = [];

  Future<List> userList(){
    return _adminService.higherScoreUserList();
  }

  Future<void> sortByCreationDate() async {
    _list = await _postService.getPostList();
    _list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    var _state = SortedPost();
    _state.postList.addAll(_list);
    emit(_state);
  }

  Future<void> sortByLikesCount() async {
    _list = await _postService.getPostList();
    _list.sort((a, b) => b.likeCount.compareTo(a.createdAt));
    var _state = SortedPost();
    _state.postList.addAll(_list);
    emit(_state);
  }

  void sortPostList(PostFilterOptions? option) {
    print(option);
    switch (option) {
      case PostFilterOptions.BY_CREATION_DATE:
        sortByCreationDate();
        break;
      case PostFilterOptions.BY_LIKES:
        sortByLikesCount();
        break;
      default:
    }
  }
  
}


abstract class AdminState{
  bool isBusy = false;
  List<Post> postList = [];
}

class SortedPost extends AdminState{

}

class InitialAdminState extends AdminState{
  @override
  bool isBusy = false;

  @override
  List<Post> postList = [];
}