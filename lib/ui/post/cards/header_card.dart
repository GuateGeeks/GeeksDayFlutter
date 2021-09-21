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
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                child: state.getPost()!.userimage == null
                    ? Container()
                    : SvgPicture.string(
                        multiavatar(state.getPost()!.userimage)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      state.getPost()!.username,
                      style: Theme.of(context).textTheme.headline1,
                    ),
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
    );
  }
}
