import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/ui/post/cards/post_options.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostCubit state = BlocProvider.of<PostCubit>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 15, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              //container to show the user's avatar
              Container(
                width: 45,
                height:45,
                child: SvgPicture.string(
                  multiavatar(state.getPost()!.userimage),
                )
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
          SizedBox(width: 5),
          Container(
            alignment: Alignment.topLeft,
            child: PostOptions(),
          ),
        ],
      ),
    );
  }
}
