import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/models/auth_user.dart';
import 'package:geeksday/provider/theme_provider.dart';
import 'package:geeksday/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static Widget create() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedOut) {
          _navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(Routes.intro, (r) => false);
        } else if (state is AuthSignedIn) {
          _navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(Routes.home, (r) => false);
        }
      },
      child: MyApp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.toggleTheme(true),
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          navigatorKey: _navigatorKey,
          title: 'GeeksDay',
          onGenerateRoute: Routes.routes,
        );
      },
    );
  }
}
