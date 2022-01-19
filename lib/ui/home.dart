import 'package:geeksday/models/events.dart';
import 'package:geeksday/ui/main_drawer.dart';
import 'package:geeksday/ui/post/post_list.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Events? event;
  static Widget create(BuildContext context) {
    return Home();
  }

  const Home({Key? key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Image.asset(
            'guategeeks-logo-clear.png',
            width: 150,
            fit: BoxFit.cover,
          )),
      endDrawer: Drawer(
        child: MainDrawer(idEvent: event!.id),
      ),
      body: PostList(idEvent: event!.id),
    );
  }
}
