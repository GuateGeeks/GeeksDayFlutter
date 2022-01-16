import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/posts/post_cubit.dart';
import 'package:geeksday/models/post.dart';

class PostOptions extends StatefulWidget {
  final Post post;
  PostOptions({Key? key, required this.post}) : super(key: key);

  @override
  _PostOptionsState createState() => _PostOptionsState();
}

class _PostOptionsState extends State<PostOptions> {
  @override
  Widget build(BuildContext context) {
    var userData = BlocProvider.of<AuthCubit>(context).getUser();
    PostCubit state = BlocProvider.of<PostCubit>(context);
    List<String> choices = [];

    if (state.isOwnedBy(userData.uid) || userData.isadmin == true) {
      choices.add(Constants.Delete);
    }
    if(userData.isadmin == true){
      choices.add(Constants.DeleteUser);
    }
    //show list of actions that can be performed on the post
    return PopupMenuButton<String>(
      tooltip: "Ver Opciones",
      itemBuilder: (BuildContext context) {
        return choices.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
      onSelected: choiceAction,
    );
  }

  //function to carry out the selected action
  void choiceAction(String choice) {
    PostCubit state = BlocProvider.of<PostCubit>(context);
    String idPostDelete = widget.post.id;
    BlocProvider.of<PostCubit>(context).postDeletion(idPostDelete);
  }
}

//List of possible actions that can be performed on the post, at the moment it can only be eliminated
class Constants {
  static const String Delete = "Eliminar";
  static const String DeleteUser = "Bannear Usuario";

  static const List<String> choices = <String>[
    Delete,
    DeleteUser,
  ];
}
