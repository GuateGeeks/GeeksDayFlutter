import 'dart:async';

import 'package:geeksday/bloc/feed_cubit.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:geeksday/ui/post/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostList extends StatefulWidget {
  final String idEvent;
  const PostList({Key? key, required this.idEvent}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedCubit(PostService(), widget.idEvent),
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
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: RefreshIndicator(
              onRefresh: () {
                return BlocProvider.of<FeedCubit>(context).getPostList();
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

  Widget showEvents(FeedState state){
    if(state.postList.isEmpty){
      return emptyPostList();
    }else{
      return postList(state);
    }
  }

  Widget emptyPostList(){
    return Center(child: Text("Este evento no contiene publicaciones"));
  }

  Widget postList(FeedState state){
    return  ScrollConfiguration(
      behavior:
          ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: RefreshIndicator(
        onRefresh: () {
          return BlocProvider.of<FeedCubit>(context).getPostList();
        },
        
        child: ListView(
          
          children: state.postList.map((post) {
            return PostCard(post: post);
          }).toList(),
        ),
      ),
    );
  }



}
