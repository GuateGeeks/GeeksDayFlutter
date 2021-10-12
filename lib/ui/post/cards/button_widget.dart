import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/ui/post/post_comment.dart';

class ButtonWidget extends StatefulWidget {
  ButtonWidget({Key? key}) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  //variable to check if the user has clicked the like button
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    PostCubit cubit = BlocProvider.of<PostCubit>(context);
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                //show the number of likes of the post
                cubit.getLikesCountText(),
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
              child: Row(
                children: [
                  //Like button
                  likeButton(width),
                  SizedBox(width: 5.0),
                  //Comment button
                  commentButton(width, state.post),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  //function to add a like to the post
  Widget likeButton(width) {
    String userId = BlocProvider.of<AuthCubit>(context).getUserId();
    isLiked = BlocProvider.of<PostCubit>(context).likedByMe(userId);
    return IconButton(
      hoverColor: Colors.transparent,
      onPressed: (){
        likePost(context);
        isLiked = !isLiked;
      },
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Color.fromRGBO(229, 21, 21, 1) : Colors.grey,
      ),
    );
  }

  //function to add comments to the post
  Widget commentButton(width, Post post) {
    return IconButton(
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
        Icons.chat_bubble, color: Colors.grey,
        size: 20,
      ),
    );
  }

  //function to know which user has liked the post
  void likePost(BuildContext context) {
    String userId = BlocProvider.of<AuthCubit>(context).getUserId();
    BlocProvider.of<PostCubit>(context).toggleLikeToPost(userId);
  }
}
