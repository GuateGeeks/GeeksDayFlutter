import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/services/navigationService.dart';
import 'package:geeksday/ui/locator.dart';
import 'package:geeksday/ui/router/router.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  static Widget create() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedOut) {
          locator<NavigationService>().navigateTo('/login');
        } else if (state is AuthSignedIn) {
          locator<NavigationService>().navigateTo('/eventos');
        }
      },
      child: MyApp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, notifier, child) {
          return MaterialApp(
            title: 'GeeksDay',
            debugShowCheckedModeBanner: false,
            theme:
                notifier.darkTheme ? MyThemes.darkTheme : MyThemes.lightTheme,
            initialRoute: '/login',
            onGenerateRoute: Flurorouter.router.generator,
            navigatorKey: locator<NavigationService>().navigatorKey,
          );
        },
      ),
    );
  }
}
