import 'package:geeksday/bloc/posts/feed_cubit.dart';
import 'package:geeksday/models/post.dart';
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
      child: Builder(
        builder: (context){
          BlocProvider.of<FeedCubit>(context).getPostList();
          return postListBody(context);
        }
      ),
    );
  }

  Widget postListBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;

    return BlocBuilder<FeedCubit, FeedState>(
      builder: (context, state) {
        if(!(state is PostLoaded)){
          return Center(child: CircularProgressIndicator());
        }

        final posts = state.post;

        return (posts.isEmpty) 
                ? postListEmpty() 
                : showPostList(context, maxWidth, posts);
    });
  }

  Widget showPostList(BuildContext context,  double maxWidth, List<Post> posts){
    return Center(
      child: Container(
        width: maxWidth,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: RefreshIndicator(
            onRefresh: () => BlocProvider.of<FeedCubit>(context).getPostList(),
            child: ListView(  
              children: posts.map((post){
                return PostCard(post: post);
              }).toList(),
            ),
          )
        ),
      ),
    );
  }

  Widget postListEmpty(){
    return Center(  
      child: Text("Aún no hay posts para este evento"),
    );
  }
}
