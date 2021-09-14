import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/provider/theme_provider.dart';
import 'package:geeksday/routes.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:geeksday/ui/main_drawer.dart';
import 'package:geeksday/ui/post/post_create.dart';
import 'package:geeksday/ui/post/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static Widget create(BuildContext context) {
    return Home();
  }

  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: ScaffoldHome(),
        );
      },
    );
  }
}

class ScaffoldHome extends StatelessWidget {
  const ScaffoldHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(235, 235, 235, .6),
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
