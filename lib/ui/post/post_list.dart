import 'package:geeksday/bloc/posts/feed_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/ui/post/post_card.dart';
import 'package:geeksday/ui/setting.dart';

class PostList extends StatelessWidget {
  final String idEvent;
  PostList({Key? key, required this.idEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        title: Image.asset(
          'assets/guateGeeksLogo.png',
          width: 150,
          fit: BoxFit.cover,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Settings();
                  },
                ),
              );
            },
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => FeedCubit(PostService(), idEvent),
        child: Builder(builder: (context) {
          return Center(
            child: postListBody(context),
          );
        }),
      ),
    );
  }

  Widget postListBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;

    return BlocBuilder<FeedCubit, FeedState>(builder: (context, state) {
      var getPostList = BlocProvider.of<FeedCubit>(context).getPostList();
      if (!(state is PostLoaded)) {
        return Center(child: CircularProgressIndicator());
      }
      final posts = state.post;
      return (posts.isEmpty)
          ? postListEmpty()
          : showPostList(context, maxWidth, posts, getPostList);
    });
  }


  Widget showPostList(context, double maxWidth, List<Post> posts, getPostList) {
    return Center(
      child: Container(
        width: maxWidth,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: RefreshIndicator(
            onRefresh: () => getPostList,
            child: ListView(
              children: posts.map((post) {
                return PostCard(post: post);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget postListEmpty() {
    return Stack(
      children: [
        Center(
          child: Text("Aún no hay posts para este evento"),
        ),
      ],
    );
  }
}
