import 'dart:math';

import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/ui/inputs_form/email_form.dart';
import 'package:geeksday/ui/inputs_form/password_form.dart';
import 'package:geeksday/ui/inputs_form/repeat_password_form.dart';
import 'package:geeksday/ui/inputs_form/username_form.dart';

import 'helpers/return_button.dart';

class EmailCreate extends StatefulWidget {
  static Widget create(BuildContext context) => EmailCreate();

  @override
  _EmailCreateState createState() => _EmailCreateState();
}

class _EmailCreateState extends State<EmailCreate> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  String? emailAndUsernameValidator(String? value) {
    return (value == null || value.isEmpty)
        ? 'Este es un campo requerido'
        : null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Este es un campo requerido';
    if (value.length < 6) return 'La contraseña debe tener al menos 6 letras';
    if (_passwordController.text != _repeatPasswordController.text)
      return 'Las contraseñas no coinciden';
    return null;
  }

  String randomAvatar = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 500 ? 500 : width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "assets/guateGeeksLogo.png",
          width: 200,
          height: 40,
          fit: BoxFit.cover,
        ),
        leading: ReturnButton(),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0E89AF),
              Color(0xFF4B3BAB),
            ],
          ),
        ),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (_, state) {
            return cardLogin(context, maxWidth, state);
          },
        ),
      ),
    );
  }

  Widget cardLogin(context, maxWidth, state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
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
                      height: 11,
                    ),
                    formLogin(state),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formLogin(AuthState state) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          EmailForm(emailAndUsernameValidator, _emailController),
          SizedBox(height: 8),
          //Show input Username
          UsernameForm(emailAndUsernameValidator, _usernameController),
          SizedBox(height: 8),
          //Show input Password
          PasswordForm(passwordValidator, _passwordController),
          SizedBox(height: 8),
          //Show input Repear Password
          RepeatPasswordForm(passwordValidator, _repeatPasswordController),
          SizedBox(height: 22),
          saveUser(),
        ],
      ),
    );
  }

  Widget saveUser() {
    return Container(
      child: ElevatedButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(120, 40)),
            side: MaterialStateProperty.all(
              const BorderSide(
                color: Color.fromRGBO(255, 255, 255, 0.79),
                width: 1,
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(75, 59, 171, 1)),
          ),
          onPressed: () {
            var random = List.generate(12, (_) => Random().nextInt(100));
            randomAvatar = random.join();
            if (_formKey.currentState?.validate() == true) {
              context.read<AuthCubit>().createUserWithEmailAndPassword(
                    _emailController.text,
                    _usernameController.text,
                    _passwordController.text,
                    randomAvatar,
                  );
            }
          },
          child: Text(
            "Registrarse",
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.white,
              // fontFamily: 'Biryani',
            ),
          )),
    );
  }
}
