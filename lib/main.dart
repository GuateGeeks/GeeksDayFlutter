import 'package:geeksday/app.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/services/implementation/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
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
