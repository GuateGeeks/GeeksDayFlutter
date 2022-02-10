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
    return Scaffold(
      body: PostList(event: event!),
      bottomNavigationBar: BottomNavigation(event: event!),
    );
  }
}
