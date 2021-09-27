import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/ui/post/cards/body_cards.dart';
import 'package:geeksday/ui/post/cards/button_widget.dart';
import 'package:geeksday/ui/post/cards/header_card.dart';

class PostCard extends StatelessWidget {
  //final PostModel postData;
  final Post post;

  PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostCubit(PostService(), this.post),
      child: builder(context),
    );
  }

  Widget builder(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              HeaderCard(),
              BodyCard(),
              ButtonWidget(),
            ],
          ),
        ),
    );
  }
}
