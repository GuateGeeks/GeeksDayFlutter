import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:geeksday/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/ui/helpers/return_button.dart';
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

  String? emptyValidator(String? value) {
    return (value == null || value.isEmpty) ? 'Este es un campo requerido' : null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Este es un campo requerido';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 500 ? 500 : width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar sesión con Email'),
        leading: ReturnButton(),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (_, state) {
          return Center(
            child: Container(
              width: maxWidth,
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
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (state is AuthSigningIn)
                              Center(child: CircularProgressIndicator()),
                            if (state is AuthError)
                              Text(
                                state.message,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 24),
                              ),
                            //Input email
                            SizedBox(height: 8),
                            EmailForm(emptyValidator, _emailController),

                            //Input Password
                            SizedBox(height: 8),
                            PasswordForm(
                                passwordValidator, _passwordController),
                            SizedBox(height: 22),

                            //Button Login
                            Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: 18)),
                                ),
                                child: Center(
                                    child: Text(
                                  'Iniciar Sesión',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                )),
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    context
                                        .read<AuthCubit>()
                                        .signInWithEmailAndPassword(
                                          _emailController.text,
                                          _passwordController.text,
                                        );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    singInGoogle(context, authCubit),
                    SizedBox(height: 20),
                    singUp(context, authCubit),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //Button Sing In whith google
  Widget singInGoogle(context, authCubit) {
    return Column(
      children: [
        Text(
          "Iniciar Sesión con",
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: GestureDetector(
              onTap: () => authCubit.signInWithGoogle(),
              child: Image(
                image: AssetImage('assets/icon_google.png'),
                fit: BoxFit.cover,
                height: 20,
              )),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            primary: Colors.white, // <-- Button color
            onPrimary: Colors.red, // <-- Splash color
          ),
        ),
      ],
    );
  }

  //Button Sing Up
  Widget singUp(BuildContext context, authCubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "¿Aún no tienes una cuenta?",
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(width: 5.0),
        TextButton(
          child: Text('Registrate'),
          style: Theme.of(context).textButtonTheme.style,
          onPressed: () {
            authCubit.reset();
            Navigator.pushNamed(context, Routes.createAccount);
          },
        )
      ],
    );
  }
}
