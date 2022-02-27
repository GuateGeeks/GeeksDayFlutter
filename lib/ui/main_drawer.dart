import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/services/implementation/auth_service.dart';
import 'package:geeksday/ui/admin/admin_metric.dart';
import 'package:geeksday/ui/event/main_events.dart';
import 'package:geeksday/ui/setting.dart';
import 'package:geeksday/ui/user_profile.dart';
import 'package:multiavatar/multiavatar.dart';

class MainDrawer extends StatelessWidget {
  String idEvent;
  MainDrawer({Key? key, required this.idEvent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit(AuthService());
    var userData = BlocProvider.of<AuthCubit>(context).getUser();
    return ListView(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50.0),
              color: Colors.transparent,
              width: 115,
              child: Container(
              height: 150,
                child: SvgPicture.string(
                  multiavatar(userData.image),
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            userData.name,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SizedBox(height: 20.0),
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return UserProfile();
                },
              ),
            );
          },
          leading: Icon(Icons.person, color: Theme.of(context).iconTheme.color),
          title: Text(
            "Perfil",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return MainEvent();
                },
              ),
            );
          },
          leading: Icon(Icons.event_available,
              color: Theme.of(context).iconTheme.color),
          title: Text(
            "Eventos",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        userData.isadmin == true
            ? ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AdminMetric(idEvent: idEvent);
                      },
                    ),
                  );
                },
                leading: Icon(Icons.admin_panel_settings,
                    color: Theme.of(context).iconTheme.color),
                title: Text(
                  "Admin",
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            : Container(),
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return Settings();
                },
              ),
            );
          },
          leading:
              Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
          title: Text(
            "Configuración",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        ListTile(
          onTap: () {
            authCubit.signOut();
          },
          leading: Icon(Icons.logout, color: Theme.of(context).iconTheme.color),
          title: Text(
            "Cerrar sesión",
            style: Theme.of(context).textTheme.headline6,
          ),
        )
      ],
    );
  }
}
