import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/services/navigationService.dart';
import 'package:geeksday/ui/locator.dart';
import 'package:geeksday/ui/post/modal_create_post.dart';

class BottomNavigation extends StatelessWidget {
  final String idEvent;
  BottomNavigation({required this.idEvent});

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
    return GestureDetector(
      onTap: () {
        locator<NavigationService>().navigateTo('/evento/' + idEvent);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 1),
            child: SvgPicture.asset(
              "assets/icons/home.svg",
              height: 33,
              width: 32,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            "Inicio",
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }

  Widget searchModal(BuildContext context) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            child: SvgPicture.asset(
              "assets/icons/search.svg",
              height: 24,
              width: 28,
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            "Buscar",
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }

  Widget postModal(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height / 2,
            // width: 800,
            child: ModalCreatePost(idEvent: idEvent),
            // child: PostCreate(idEvent: event!.id),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2),
            child: SvgPicture.asset(
              "assets/icons/plus.svg",
              height: 32,
              width: 32,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            "Post",
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }

  Widget eventPage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        locator<NavigationService>().navigateTo('/eventos');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2.5),
            child: SvgPicture.asset(
              "assets/icons/events.svg",
              height: 30,
              width: 30,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            "Eventos",
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }

  Widget profilePage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AuthUser userData = BlocProvider.of<AuthCubit>(context).getUser()!;
        locator<NavigationService>().navigateTo('/perfil/' + userData.uid);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.5),
            child: SvgPicture.asset(
              "assets/icons/user.svg",
              height: 26,
              width: 29,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "Perfil",
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
