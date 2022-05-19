import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/provider/theme_provider.dart';
import 'package:geeksday/services/implementation/auth_service.dart';
import 'package:geeksday/ui/guategeeks/elements.dart';
import 'package:geeksday/ui/helpers/return_button.dart';
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
            const Divider(
              height: 30,
              thickness: 1,
            ),
            application(context),
            ...admin(context)
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
              onTap: () {
                Navigator.pushNamed(context, "/socialMetrics");
              },
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
          leading: Icon(Icons.home),
          title: Text(
            "Cuenta",
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
          leading: Icon(Icons.home),
          title: Text(
            "Cuenta",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text(
            "Cuenta",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        ListTile(
          leading: Icon(Icons.logout),
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
          activeColor: Color(0xFF0E89AF),
          onChanged: (val) {
            notifier.toogleTheme();
          },
          value: notifier.darkTheme,
        );
      },
    );
  }
}
