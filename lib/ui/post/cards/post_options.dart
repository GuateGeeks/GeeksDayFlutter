import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/services/implementation/post_service.dart';

class PostOptions extends StatefulWidget {
  PostOptions({Key? key}) : super(key: key);

  @override
  _PostOptionsState createState() => _PostOptionsState();
}

class _PostOptionsState extends State<PostOptions> {
  @override
  Widget build(BuildContext context) {
    var userId = BlocProvider.of<AuthCubit>(context).getUserId();
    PostCubit state = BlocProvider.of<PostCubit>(context);
    List<String> choices = [];

    if (state.isOwnedBy(userId)) {
      choices.add(Constants.Delete);
    }
    //show list of actions that can be performed on the post
    return PopupMenuButton<String>(
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
    var a = firestoreInstance.clearPersistence();
    print(a);
  }
}

//List of possible actions that can be performed on the post, at the moment it can only be eliminated
class Constants {
  static const String Delete = "Eliminar";

  static const List<String> choinces = <String>[
    Delete,
  ];
}
