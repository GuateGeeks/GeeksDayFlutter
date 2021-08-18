import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:like_button/like_button.dart';
import 'package:geeksday/routes.dart';

class ButtonWidget extends StatefulWidget {
  ButtonWidget({Key? key}) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool isLiked = false;
  int likeCount = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    PostCubit state = BlocProvider.of<PostCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            state.getLikesCountText(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              likeButton(width),
              SizedBox(
                width: 20.0,
              ),
              commentButton(width),
            ],
          ),
        ),
      ],
    );
  }

  //function like button
  Widget likeButton(width) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: (width > 620)
            // If the screen size is greater than 620
            ? MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 100, vertical: 15))
            //If the screen size es greater than 450
            : (width > 450
                ? MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 60, vertical: 15))
                //If the screen size is less than 450
                : MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                  )),
        backgroundColor:
            MaterialStateProperty.all<Color>(Color.fromRGBO(235, 235, 235, .6)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
      ),
      //likeButton library implementation
      child: LikeButton(
        likeBuilder: (bool isLike) {
          return Icon(
            Icons.favorite,
            color: isLike ? Color.fromRGBO(229, 21, 21, 1) : Colors.grey,
          );
        },
        onTap: (bool isLike) async {
          likePost(context);
          return !isLike;
        },
        isLiked: BlocProvider.of<PostCubit>(context).isLiked(),
        likeCount: BlocProvider.of<PostCubit>(context).getLikesCount(),
        countBuilder: (count, isLiked, text) {
          Widget result;
          if (count == 0) {
            result = Text(
              "LIKE",
              style: TextStyle(
                  color: isLiked ? Color.fromRGBO(229, 21, 21, 1) : Colors.grey,
                  fontWeight: FontWeight.bold),
            );
          } else
            result = Text("LIKE",
                style: TextStyle(
                    color:
                        isLiked ? Color.fromRGBO(229, 21, 21, 1) : Colors.grey,
                    fontWeight: FontWeight.bold));
          return result;
        },
      ),
    );
  }

  Widget commentButton(width) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, Routes.postComment);
      },
      style: ButtonStyle(
        padding: (width > 620)
            // If the screen size is greater than 620
            ? MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 95, vertical: 18))
            // If the screen size is greater than 620
            : (width > 450
                ? MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 48, vertical: 18))
                // If the screen size is less than 620
                : MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 19, vertical: 18),
                  )),
        backgroundColor:
            MaterialStateProperty.all<Color>(Color.fromRGBO(235, 235, 235, .6)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
      ),
      icon: Icon(Icons.chat_bubble, color: Colors.grey),
      label: Text(
        "COMMENT",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  void likePost(BuildContext context) {
    String userId = BlocProvider.of<AuthCubit>(context).getUserId();
    BlocProvider.of<PostCubit>(context).toggleLikeToPost(userId);
  }
}
