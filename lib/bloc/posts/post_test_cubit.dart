
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/post_service.dart';

class PostTestCubit extends Cubit<PostTestState>{
  final PostServiceBase postService;
  Post? post;

  PostTestCubit(this.postService, this.post) : super(PostTestInitialState());

  Future<void> getPost() async{
    final post = postService.listadoPost();
    post.listen((event) {
      emit(PostLoaded1(postList: event));
      
    },
      onDone: (){},
    );
  }



}



abstract class PostTestState extends Equatable {
  const PostTestState();
}

class PostTestInitialState extends PostTestState {
   @override
  List<Object> get props => [];
}

class PostLoading extends PostTestState {
   @override
  List<Object> get props => [];
}

class PostLoaded1 extends PostTestState{
  final List<Post> postList;
  
  PostLoaded1({required this.postList});
   @override
  List<Object> get props => [postList];
}