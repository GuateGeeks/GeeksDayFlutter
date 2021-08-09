import 'dart:html';

import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/post_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  final PostServiceBase _postService;
  File? _pickedImage;

  PostCubit(this._postService) : super(PostInitialState());
  Future<void> reset() async => emit(PostInitialState());

  Future<void> createPost(String text) async {
    Post newPost = Post(text: text);
    _postService.createPost(newPost, _pickedImage!);
  }

  void setImage(File image) {
    _pickedImage = image;
  }

  Future<String> getImageURL(String uid) {
    return _postService.getImageURL(uid);
  }

  Stream getPostStream() {
    return _postService.getPostStream();
  }
}

abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class NewPostState extends Equatable {}

class PostInitialState extends PostState {}
