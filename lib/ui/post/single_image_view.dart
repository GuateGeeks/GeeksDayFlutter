import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/posts/feed_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:geeksday/ui/helpers/return_button.dart';

class SingleImageView extends StatelessWidget {
  String idEvent;
  String idPost;
  SingleImageView({required this.idEvent, required this.idPost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: ReturnButton(), 
      ),
      backgroundColor: Colors.black,
      body: BlocProvider(  
        create: (_) => FeedCubit(PostService(), idEvent),
        child: bodySingleImage(),
      ),
      // body: Center(
      //   child: Image.network(image)
      // ),
    );
  }

  Widget bodySingleImage(){
    return BlocBuilder<FeedCubit, FeedState>(builder: (context, state){
      BlocProvider.of<FeedCubit>(context).getPostById(idPost);
      if(state is GetPostById){
        Post post = state.post;
        return Center(  
          child: Image.network(post.imageRoute!),
        );
      }else{
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}