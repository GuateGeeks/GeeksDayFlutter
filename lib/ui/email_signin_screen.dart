import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart' as rive;
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/routes.dart';
import 'package:geeksday/ui/inputs_form/email_form.dart';
import 'package:geeksday/ui/inputs_form/password_form.dart';

class EmailSignIn extends StatefulWidget {
  static Widget create(BuildContext context) => EmailSignIn();

  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// Controller for playback
  late rive.RiveAnimationController blinkController;
  late rive.RiveAnimationController noLookController;

  /// Is the animation currently playing?
  bool _isBlinkPlaying = false;
  bool _isNoLookPlaying = false;

  @override
  void initState() {
    super.initState();
    blinkController = rive.OneShotAnimation(
      '2_blink',
      autoplay: false,
      onStop: () => setState(() => _isBlinkPlaying = false),
      onStart: () => setState(() => _isBlinkPlaying = true),
    );
    noLookController = rive.OneShotAnimation(
      'no_look',
      autoplay: false,
      onStop: () => setState(() => _isNoLookPlaying = false),
      onStart: () => setState(() => _isNoLookPlaying = true),
    );
    _emailController.addListener(
        () => _isBlinkPlaying ? null : blinkController.isActive = true);
    _passwordController.addListener(
        () => _isNoLookPlaying ? null : noLookController.isActive = true);
  }

  String? emptyValidator(String? value) {
    return (value == null || value.isEmpty)
        ? 'Este es un campo requerido'
        : null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Este es un campo requerido';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();

    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 400 ? 400 : width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "assets/guateGeeksLogo.png",
          width: 200,
          height: 37,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 0.9,
            colors: [
              Color(0xFF0E89AF),
              Color(0xFF4B3BAB),
            ],
          ),
        ),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (_, state) {
            return cardLogin(maxWidth, state, authCubit);
          },
        ),
      ),
    );
  }

  Widget cardLogin(double maxWidth, AuthState state, authCubit) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 90),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
          child: Stack(
            alignment: AlignmentDirectional.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                width: maxWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(255, 255, 255, 0.79)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Iniciar Sesión",
                        style: Theme.of(context).textTheme.overline,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      formLogin(state),
                      SizedBox(height: 15),
                      forgotPassword(),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -20,
                child: Container(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      primary: Color(0xFF4B3BAB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      authCubit.reset();
                      Navigator.pushNamed(context, Routes.createAccount);
                    },
                    child: Text(
                      "Registrarse",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.white,
                        // fontFamily: 'Biryani',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -135,
                child: SizedBox(
                    width: maxWidth,
                    height: 160,
                    child: rive.RiveAnimation.asset(
                      'rive/guategeeks_logo.riv',
                      animations: const ['idle'],
                      controllers: [blinkController, noLookController],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget formLogin(AuthState state) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state is AuthSigningIn)
            Center(child: CircularProgressIndicator()),
          if (state is AuthError)
            Text(
              state.message,
              style: TextStyle(color: Colors.red, fontSize: 24),
            ),
          //Input email
          SizedBox(height: 8),
          EmailForm(emptyValidator, _emailController),
          //Input Password
          SizedBox(height: 8),
          PasswordForm(passwordValidator, _passwordController),
          SizedBox(height: 22),
          loginButton(),
        ],
      ),
    );
  }

  Widget loginButton() {
    return Center(
      child: Container(
        width: 200,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20),
            primary: Color(0xFF0E89AF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Center(
            child: Text(
              "Ingresar",
              style: TextStyle(
                fontSize: 19,
                color: Colors.white,
              ),
            ),
          ),
          onPressed: () {
            if (_formKey.currentState?.validate() == true) {
              context.read<AuthCubit>().signInWithEmailAndPassword(
                    _emailController.text,
                    _passwordController.text,
                  );
            }
          },
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return InkWell(
      onTap: () {},
      child: Text(
        "Recuperar contraseña",
        style: TextStyle(
          color: Color(0xFF4A4A4A),
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
