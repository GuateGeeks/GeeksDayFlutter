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
    double maxWidth = width > 400 ? 400 : width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "assets/guateGeeksLogo.png",
          width: 200,
          height: 37,
        ),
        leading: ReturnButton(),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              radius: 0.9,
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
      ),
    );
  }

  Widget cardLogin(context, maxWidth, state) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 90),
          padding: EdgeInsets.fromLTRB(25, 15, 25, 35),
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
                child: Column(
                  children: [
                    Text(
                      "Registrarse",
                      style: Theme.of(context).textTheme.overline,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    formLogin(state),
                    SizedBox(height: 15),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -20,
                child: Container(
                  width: 150,
                  child: saveUser(),
                ),
              ),
              Positioned(
                top: -135,
                child: Container(
                  child: Image.asset('assets/ojos.png'),
                ),
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
      child: Stack(
        children: [
          Column(
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
              EmailForm(emailAndUsernameValidator, _emailController, submitForm),
              SizedBox(height: 8),
              //Show input Username
              UsernameForm(emailAndUsernameValidator, _usernameController, submitForm),
              SizedBox(height: 8),
              //Show input Password
              PasswordForm(passwordValidator, _passwordController, submitForm),
              SizedBox(height: 8),
              //Show input Repear Password
              RepeatPasswordForm(passwordValidator, _repeatPasswordController, submitForm),
            ],
          ),
        ],
      ),
    );
  }

  Widget saveUser() {
    return Container(
      width: 230,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF0E89AF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          var random = List.generate(12, (_) => Random().nextInt(100));
          randomAvatar = random.join();
          submitForm();
        },
        child: Text(
          "Registrarme",
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.white,
            // fontFamily: 'Biryani',
          ),
        ),
      ),
    );
  }

  void submitForm() {
    if (_formKey.currentState?.validate() == true) {
      context.read<AuthCubit>().createUserWithEmailAndPassword(
            _emailController.text,
            _usernameController.text,
            _passwordController.text,
            randomAvatar,
          );
    }
  }
}
