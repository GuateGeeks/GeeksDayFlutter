import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/ui/post/post_comment.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    PostCubit cubit = BlocProvider.of<PostCubit>(context);
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
          child: Row(
            children: [
              //Like button
              likeButton(context, width, cubit),
              SizedBox(width: 5.0),
              //Comment button
              commentButton(context, width, state.post, cubit),
            ],
          ),
        );   
      },
    );
  }
  //   //function to add a like to the post
  Widget likeButton(BuildContext context, width, cubit) {
    String userId = BlocProvider.of<AuthCubit>(context).getUserId();
    bool isLiked = BlocProvider.of<PostCubit>(context).likedByMe(userId);
    return Row(
      children: [
        IconButton(
          hoverColor: Colors.transparent,
          onPressed: (){
            likePost(context);
            isLiked = !isLiked;
          },
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Color.fromRGBO(229, 21, 21, 1) : Colors.grey,
          ),
        ),
        Text(
          //show the number of likes of the post
          cubit.getLikesCountText(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
  //   //function to add comments to the post
  Widget commentButton(BuildContext context, width, Post post, PostCubit cubit) {
    return Row(
      children: [
        IconButton(
          hoverColor: Colors.transparent,
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return PostComment(post);
                },
              ),
            );
          },
          icon: Icon(
            Icons.comment_sharp, color: Colors.grey,
            size: 20,
          ),
        ),
        Text(
          //show the number of comments of the post
          cubit.countComments(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }

  //function to know which user has liked the post
  void likePost(BuildContext context) {
    String userId = BlocProvider.of<AuthCubit>(context).getUserId();
    BlocProvider.of<PostCubit>(context).toggleLikeToPost(userId);
  }
}
