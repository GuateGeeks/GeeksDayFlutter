import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/provider/theme_provider.dart';
import 'package:geeksday/services/implementation/auth_service.dart';
import 'package:geeksday/services/navigationService.dart';
import 'package:geeksday/ui/guategeeks/elements.dart';
import 'package:geeksday/ui/locator.dart';
import 'package:provider/provider.dart';

class Configuration extends StatelessWidget {
  const Configuration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 700 ? 700 : width;
    return GuateGeeksScaffold(
      body: settings(maxWidth, context),
    );
  }

  Widget settings(maxWidth, context) {
    return Center(
      child: SizedBox(
        width: maxWidth,
        child: Column(
          children: [
            const Divider(
              height: 1,
              thickness: 1,
            ),
            account(context),
            ...admin(context),
            application(context),
          ],
        ),
      ),
    );
  }

  List<Widget> admin(context) {
    AuthUser? user = BlocProvider.of<AuthCubit>(context).getUser();
    return !user!.isadmin
        ? [Container()]
        : [
            ListTile(
              title: Text(
                "Administración",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.bar_chart),
              title: Text(
                "Social Metrics",
                style: Theme.of(context).textTheme.headline5,
              ),
            )
          ];
  }

  Widget account(context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          title: Text(
            "Cuenta",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        ListTile(
          leading: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).appBarTheme.backgroundColor),
              child: const Icon(Icons.person)),
          title: Text(
            "Perfil",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        ListTile(
          title: Text(
            'Modo Oscuro',
            style: Theme.of(context).textTheme.headline5,
          ),
          trailing: changeTheme(context),
        ),
      ],
    );
  }

  Widget application(context) {
    final authCubit = AuthCubit(AuthService());
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          title: Text(
            "Aplicación",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          onTap: () {
            authCubit.signOut();
          },
          title: Text(
            "Salir",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    );
  }

  Widget changeTheme(context) {
    return Consumer<ThemeProvider>(
      builder: (context, notifier, child) {
        return Switch(
          activeColor: const Color(0xFF0E89AF),
          onChanged: (val) {
            notifier.toogleTheme();
          },
          value: notifier.darkTheme,
        );
      },
    );
  }
}
