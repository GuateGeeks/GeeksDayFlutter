import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  static Widget create(BuildContext context) {
    return Settings();
  }

  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 500 ? 500 : width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuracion'),
      ),
      body: settings(maxWidth, context),
    );
  }

  Widget settings(maxWidth, context) {
    return Center(
      child: Container(
        width: maxWidth,
        child: Card(
          child: ListView(
            children: [
              ListTile(
                title: Text('Modo Oscuro',
                    style: Theme.of(context).textTheme.headline6),
                trailing: changeTheme(context),
              ),
              Divider(
                height: 25,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget changeTheme(context) {
    var theme = BlocProvider.of<AuthCubit>(context);
    return Switch(
      value: theme.getTheme(),
      onChanged: (value) {
        print(value);
        theme.changeTheme();
       
      },
    );
  }
}
