import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/ui/post/cards/post_options.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userId = BlocProvider.of<AuthCubit>(context).getUserId();

    PostCubit state = BlocProvider.of<PostCubit>(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 15, 15, 5),
      //the header of the post is being shown by a listView because that way we show the complete avatar, if the listView is removed when hovering the mouse over an icon of the post, the avatar is cut
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Stack(
                    children: [
                      //container to show the user's avatar
                      Container(
                        width: 45,
                        height: 45,
                        child: SvgPicture.string(
                            multiavatar(state.getPost()!.userimage)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //we show the user's name
                        Text(
                          state.getPost()!.username,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        //We are using the getDatePost function to correctly display the date the post was published, otherwise it is displayed in a DateTime format
                        Text(
                          state.getDatePost(state.getPost()!.createdAt),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              PostOptions(),
            ],
          ),
        ],
      ),
    );
  }
}
