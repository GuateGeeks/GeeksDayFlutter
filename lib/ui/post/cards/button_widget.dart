import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geeksday/bloc/posts/post_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/ui/post/post_comment.dart';

class ButtonWidget extends StatelessWidget {
  final Post post;
  ButtonWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    PostCubit cubit = BlocProvider.of<PostCubit>(context);
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
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

  //function to add a like to the post
  Widget likeButton(BuildContext context, width, cubit) {
    String userId = post.idUser;
    bool isLiked = BlocProvider.of<PostCubit>(context).likedByMe(userId);
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              likePost(context);
              isLiked = !isLiked;
            },
            child: isLiked
                ? SvgPicture.asset('assets/icons/is_liked.svg')
                : SvgPicture.asset('assets/icons/like.svg')),
        Container(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: Text(
            //show the number of likes of the post
            cubit.getLikesCountText(),
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ],
    );
  }

  //   //function to add comments to the post
  Widget commentButton(
      BuildContext context, width, Post post, PostCubit cubit) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return PostComment(post);
                },
              ),
            );
          },
          child: SvgPicture.asset('assets/icons/comment.svg'),
        ),
        // SizedBox(width: 10.0),
        Container(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: Text(
            //show the number of comments of the post
            cubit.countComments(),
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ],
    );
  }

  //function to know which user has liked the post
  void likePost(BuildContext context) {
    String userId = post.idUser;
    BlocProvider.of<PostCubit>(context).toggleLikeToPost(userId);
  }
}
