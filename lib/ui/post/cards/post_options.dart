import 'package:flutter/material.dart';

class PostOptions extends StatefulWidget {
  PostOptions({Key? key}) : super(key: key);

  @override
  _PostOptionsState createState() => _PostOptionsState();
}

class _PostOptionsState extends State<PostOptions> {
  @override
  Widget build(BuildContext context) {
    //show list of actions that can be performed on the post
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return Constants.choinces.map((String choice) {
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
    print("Eliminando");
  }
}

//List of possible actions that can be performed on the post, at the moment it can only be eliminated
class Constants {
  static const String Delete = "Eliminar";

  static const List<String> choinces = <String>[
    Delete,
  ];
}
