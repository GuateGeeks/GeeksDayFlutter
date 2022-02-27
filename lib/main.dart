import 'package:geeksday/app.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/services/implementation/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/ui/locator.dart';
import 'package:geeksday/ui/router/router.dart';

void main() async {
  setupLocator();
  Flurorouter.configureRoutes();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authCubit = AuthCubit(AuthService());

  runApp(
    BlocProvider(
      create: (_) => authCubit..init(),
      child: MyApp.create(),
    ),
  );
}




