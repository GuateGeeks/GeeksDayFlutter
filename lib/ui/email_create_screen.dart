import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/ui/inputs_form/email_form.dart';
import 'package:geeksday/ui/inputs_form/password_form.dart';
import 'package:geeksday/ui/inputs_form/repeat_password_form.dart';
import 'package:geeksday/ui/inputs_form/username_form.dart';
import 'package:multiavatar/multiavatar.dart';

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
    return (value == null || value.isEmpty) ? 'This is a required field' : null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'This is a required field';
    if (value.length < 6) return 'Password should be at least 6 letters';
    if (_passwordController.text != _repeatPasswordController.text)
      return 'Password do not match';
    return null;
  }

  String randomAvatar = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 500 ? 500 : width;
    return Scaffold(
      appBar: AppBar(title: Text('Create account')),
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
                      "Sing Up",
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
                            SizedBox(height: 8),
                            //Show input email
                            EmailForm(
                                emailAndUsernameValidator, _emailController),
                            SizedBox(height: 8),
                            //Show input Username
                            UsernameForm(
                                emailAndUsernameValidator, _usernameController),
                            SizedBox(height: 8),
                            //Show input Password
                            PasswordForm(
                                passwordValidator, _passwordController),

                            SizedBox(height: 8),
                            //Show input Repear Password
                            RepeatPasswordForm(
                                passwordValidator, _repeatPasswordController),
                            SizedBox(height: 22),
                            Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: 18)),
                                ),
                                child: Center(
                                    child: Text(
                                  'Sing Up',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                )),
                                onPressed: () {
                                  var random = List.generate(
                                      12, (_) => Random().nextInt(100));
                                  randomAvatar = random.join();
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    context
                                        .read<AuthCubit>()
                                        .createUserWithEmailAndPassword(
                                          _emailController.text,
                                          _usernameController.text,
                                          _passwordController.text,
                                          randomAvatar,
                                        );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
