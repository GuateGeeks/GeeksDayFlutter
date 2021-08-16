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
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 32, vertical: 15)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(235, 235, 235, .6)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ))),
                child: LikeButton(
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      Icons.favorite,
                      color: isLiked
                          ? Color.fromRGBO(229, 21, 21, 1)
                          : Colors.grey,
                    );
                  },
                  onTap: (bool isLiked) async {
                    likePost(context);
                    return true;
                  },
                  isLiked: BlocProvider.of<PostCubit>(context).isLiked(),
                  likeCount:
                      BlocProvider.of<PostCubit>(context).getLikesCount(),
                  countBuilder: (count, isLiked, text) {
                    //var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                    Widget result;
                    if (count == 0) {
                      result = Text(
                        "LIKE",
                        style: TextStyle(
                            color: isLiked
                                ? Color.fromRGBO(229, 21, 21, 1)
                                : Colors.grey,
                            fontWeight: FontWeight.bold),
                      );
                    } else
                      result = Text("LIKE",
                          style: TextStyle(
                              color: isLiked
                                  ? Color.fromRGBO(229, 21, 21, 1)
                                  : Colors.grey,
                              fontWeight: FontWeight.bold));
                    return result;
                  },
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.postComment);
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 30, vertical: 18)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(235, 235, 235, .6)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ))),
                  icon: Icon(Icons.chat_bubble, color: Colors.grey),
                  label: Text("COMMENT", style: TextStyle(color: Colors.grey)))
            ],
          ),
        ),
      ],
    );
  }

  void likePost(BuildContext context) {
    String userId = BlocProvider.of<AuthCubit>(context).getUserId();
    BlocProvider.of<PostCubit>(context).toggleLikeToPost(userId);
  }
}
