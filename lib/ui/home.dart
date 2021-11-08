import 'package:geeksday/provider/theme_provider.dart';
import 'package:geeksday/ui/main_drawer.dart';
import 'package:geeksday/ui/post/post_create.dart';
import 'package:geeksday/ui/post/post_list.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
   static Widget create(BuildContext context) {
    return Home();
  }
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'GeeksDay',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: PostList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Show modal new post
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => Container(
              width: 800,
              child: PostCreate(),
            ),
          );
        },
        tooltip: 'New',
        child: const Icon(Icons.add),
      ),
    );
  }
}
