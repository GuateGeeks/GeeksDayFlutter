import 'dart:async';

import 'package:geeksday/bloc/feed_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:geeksday/ui/post/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
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
            child: RefreshIndicator(
              onRefresh: (){
                final duration = new Duration(seconds: 2);
                new Timer(duration, () {
                  BlocProvider.of<FeedCubit>(context).getPostList();
                });
                return Future.delayed(duration);
              },
              child: ListView(
                children: state.postList.map((post) {
                  return PostCard(post: post);
                }).toList(),
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> _refresh (){
    return Future.delayed(Duration(seconds: 1));
  }
}
