import 'package:geeksday/bloc/posts/post_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/ui/post/cards/body_cards.dart';
import 'package:geeksday/ui/post/cards/header_card.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostCubit(PostService(), this.post),
      child: posts(context),
    );
  }

  Widget posts(context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: HeaderCard(post: post),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: BodyCard(post: post),
          ),
          SizedBox(
            child: Container(
              height: 10,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
