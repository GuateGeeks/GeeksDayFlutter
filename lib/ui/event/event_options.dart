import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/bloc/posts/post_cubit.dart';
import 'package:geeksday/models/post.dart';
import 'package:geeksday/services/navigationService.dart';
import 'package:geeksday/ui/locator.dart';

class EventOptions extends StatelessWidget {
  String eventId;
  EventOptions({Key? key, required this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //show list of actions that can be performed on the post
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: PopupMenuButton<String>(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        icon: const Icon(
          Icons.more_vert_rounded,
          color: Color(0xFF0E89AF),
          size: 35,
          textDirection: TextDirection.ltr,
        ),
        tooltip: "Ver Opciones",
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem<String>(
              value: "Admin",
              onTap: () {
                print("admin");
                locator<NavigationService>()
                    .navigateTo("/socialMetrics/$eventId");
                Navigator.pushNamed(context, '/admin');
              },
              child: const Text("Metrics"),
            ),
          ];
        },
        onSelected: (String choice) {
          // TODO
          print(choice);
        },
      ),
    );
  }
}
