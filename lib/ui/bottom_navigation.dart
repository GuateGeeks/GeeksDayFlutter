import 'package:flutter/material.dart';
import 'package:geeksday/models/events.dart';
import 'package:geeksday/ui/events/main_events.dart';
import 'package:geeksday/ui/home.dart';
import 'package:geeksday/ui/post/modal_create_post.dart';
import 'package:geeksday/ui/user_profile.dart';

class BottomNavigation extends StatelessWidget {
  final Events? event;
  BottomNavigation({this.event});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).backgroundColor,
      elevation: 30,
      child: Container(
        margin: EdgeInsets.only(bottom: 25),
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            homePage(context),
            searchModal(context),
            postModal(context),
            eventPage(context),
            profilePage(context),
          ],
        ),
      ),
    );
  }

  Widget homePage(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return Home(event: event);
                },
              ),
            );
          },
          icon: Icon(
            Icons.home,
            size: 30,
          ),
        ),
        Text(
          "Inicio",
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }

  Widget searchModal(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            size: 30,
          ),
        ),
        Text(
          "Buscar",
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }

  Widget postModal(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height / 2,
                // width: 800,
                child: ModalCreatePost(idEvent: event!.id),
                // child: PostCreate(idEvent: event!.id),
              ),
            );
          },
          icon: Icon(
            Icons.control_point,
            size: 30,
          ),
        ),
        Text(
          "Post",
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }

  Widget eventPage(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return MainEvents();
                },
              ),
            );
          },
          icon: Icon(
            Icons.event_available_rounded,
            size: 30,
          ),
        ),
        Text(
          "Eventos",
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }

  Widget profilePage(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return UserProfile(event: event);
                },
              ),
            );
          },
          icon: Icon(
            Icons.person,
            size: 30,
          ),
        ),
        Text(
          "Perfil",
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}
