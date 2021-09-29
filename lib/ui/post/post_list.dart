import 'package:geeksday/bloc/feed_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:geeksday/ui/post/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostList extends StatelessWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedCubit(PostService()),
      child: builder(context),
    );
  }

  Widget builder(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    return BlocBuilder<FeedCubit, FeedState>(builder: (context, state) {
      return Center(
        child: Container(
          width: maxWidth,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              children: state.postList.map((post) {
                return PostCard(post: post);
              }).toList(),
            ),
          ),
        ),
      );
    });
  }
}
