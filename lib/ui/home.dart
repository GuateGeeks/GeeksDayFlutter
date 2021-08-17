import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/routes.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:geeksday/ui/post/post_create.dart';
import 'package:geeksday/ui/post/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  static Widget create(BuildContext context) {
    return const Home();
  }

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, .6),
      appBar: AppBar(
        title: Text('GeeksDay'),
      ),
      body: PostList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Show modal new post
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) =>
                SingleChildScrollView(child: PostCreate.create(context)),
          );
        },
        tooltip: 'New',
        child: const Icon(Icons.add),
      ),
    );
  }
}
