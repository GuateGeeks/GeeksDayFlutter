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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          event!.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: Builder(  
          builder: (context){
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: 'Menú de Navegación',
            );
          }
        ),
      ),
      drawer: Drawer(
        child: MainDrawer(idEvent: event!.id),
      ),
      body: PostList(idEvent: event!.id),
    );
  }
}
