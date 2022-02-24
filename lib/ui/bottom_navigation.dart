import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/services/navigationService.dart';
import 'package:geeksday/ui/locator.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            locator<NavigationService>().navigateTo('/evento/'+idEvent);
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
                // child: ModalCreatePost(idEvent: event!.id),
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
            locator<NavigationService>().navigateTo('/eventos');
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
    AuthUser userData = BlocProvider.of<AuthCubit>(context).getUser();
    return Column(
      children: [
        IconButton(
          onPressed: () {
            locator<NavigationService>().navigateTo('/perfil/'+userData.uid);
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
