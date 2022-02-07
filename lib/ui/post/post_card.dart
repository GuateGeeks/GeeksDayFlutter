import 'package:geeksday/bloc/posts/post_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/ui/post/cards/body_cards.dart';
import 'package:geeksday/ui/post/cards/button_widget.dart';
import 'package:geeksday/ui/post/cards/header_card.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostCubit(PostService(), this.post),
      child: posts(),
    );
  }

  Widget posts() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          HeaderCard(post: post),
          BodyCard(post: post),
          ButtonWidget(post: post),
        ],
      ),
    );
  }
}
