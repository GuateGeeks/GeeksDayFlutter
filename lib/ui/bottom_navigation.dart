import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return Home(event: event);
                },
              ),
            );
          },
          child: SvgPicture.asset(
            'assets/icons/home.svg',
            color: Colors.black,
            width: 30,
            height: 30,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5),
          child: GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              color: Colors.black,
              width: 25,
              height: 25,
            ),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
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
          child: SvgPicture.asset(
            'assets/icons/plus.svg',
            color: Colors.black,
            width: 36,
            height: 36,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return MainEvents();
                },
              ),
            );
          },
          child: SvgPicture.asset(
            'assets/icons/events.svg',
            color: Colors.black,
            width: 30,
            height: 30,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return UserProfile(event: event);
                },
              ),
            );
          },
          child: SvgPicture.asset(
            'assets/icons/user.svg',
            color: Colors.black,
            width: 30,
            height: 30,
          ),
        ),
        Text(
          "user",
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}
