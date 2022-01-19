import 'package:geeksday/models/events.dart';
import 'package:geeksday/ui/main_drawer.dart';
import 'package:geeksday/ui/post/post_create.dart';
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double modalHeight = width > 500 ? height / 2 : height / 1.3;
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
      floatingActionButton: createPostButton(context, modalHeight),
      body: PostList(idEvent: event!.id),
    );
  }

    Widget createPostButton(context, modalHeight) {
    return FloatingActionButton(
      onPressed: () {
        //Show modal new post
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => Container(
            height: modalHeight,
            width: 800,
            child: PostCreate(idEvent: event!.id),
          ),
        );
      },
      tooltip: 'Crear Nuevo Post',
      child: const Icon(Icons.add),
    );
  }
}
