import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/posts/post_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/ui/post/cards/post_options.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderCard extends StatelessWidget {
  final Post post;
  const HeaderCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthUser userData =
        BlocProvider.of<AuthCubit>(context).getUserByPost(post.idUser);
    String getDatePost =
        BlocProvider.of<PostCubit>(context).getDatePost(post.createdAt);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 46,
                height: 46,
                child: SvgPicture.string(multiavatar(userData.image)),
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //we show the user's name
                    Text(
                      userData.name,
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      getDatePost,
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: SizedBox(
        height: 80,
        width: 21,
        child: PostOptions(post: post),
      ),
    );
  }
}
