import 'package:geeksday/bloc/feed_cubit.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/ui/post/post_card.dart';

class PostList extends StatelessWidget {
  final String idEvent;
  const PostList({Key? key, required this.idEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedCubit(PostService(), idEvent),
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
              child: state.postList.isEmpty
                  ? Center(child: Text("Aun no hay posts para este evento"))
                  : ListView(
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
}
