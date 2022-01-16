import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/post_service.dart';

class FeedCubit extends Cubit<FeedState> {
  final PostServiceBase _postService;
  final String idEvent;

  FeedCubit(this._postService, this.idEvent) : super(FeedInitialState());
 
  Future<void> getPostList() async {
    List<Post> _listPost = [];
    final posts = _postService.listadoPost();
    posts.listen((post) {
      post.forEach((element) {
        if(element.idEvent == idEvent){
          _listPost.add(element);
        }
      });
      emit(PostLoaded(post: _listPost));
    _listPost = [];
    }, onDone: (){},
    );
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


