import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostComment extends StatelessWidget {
  static Widget create(BuildContext context) {
    return BlocProvider(
      create: (_) => PostCubit(PostService()),
      child: const PostComment(),
    );
  }

  const PostComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Pagina para comentarios"),
    );
  }
}
