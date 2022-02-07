import 'package:geeksday/models/events.dart';
import 'package:geeksday/ui/bottom_navigation.dart';
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
    double maxWidth = width > 700 ? 700 : width;
    return Scaffold(
      body: Container(
        width: maxWidth,
        child: PostList(idEvent: event!.id),
      ),
      bottomNavigationBar: BottomNavigation(event: event!),
    );
  }
}
