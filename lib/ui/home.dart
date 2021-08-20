import 'package:geeksday/bloc/post_cubit.dart';
import 'package:geeksday/routes.dart';
import 'package:geeksday/services/implementation/post_service.dart';
import 'package:geeksday/ui/post/post_create.dart';
import 'package:geeksday/ui/post/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/ui/post/quizz_create.dart';

class Home extends StatefulWidget {
  static Widget create(BuildContext context) {
    return Home();
  }

  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int bottomSelectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        PostCreate(
          onButtonPressed: () => pageController.animateToPage(
            1,
            duration: Duration(milliseconds: 300),
            curve: Curves.linear,
          ),
        ),
        QuizzCreate(
          onButtonPressed: () => pageController.animateToPage(
            0,
            duration: Duration(milliseconds: 300),
            curve: Curves.linear,
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

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
              builder: (context) => buildPageView());
        },
        tooltip: 'New',
        child: const Icon(Icons.add),
      ),
    );
  }
}
