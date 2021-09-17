import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroScreen extends StatelessWidget {
  static Widget create(BuildContext context) => IntroScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _LoginPage(),
    );
  }
}

class _LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    final isSigningIn = authCubit.state is AuthSigningIn;

    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/icon.png',
            width: 200,
            height: 200,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Sign in or create an account',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (isSigningIn) CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              children: [
                SizedBox(height: 8),
                _LoginButton(
                  text: 'Sign in with Google',
                  imagePath: 'assets/icon_google.png',
                  color: Colors.white,
                  textColor: Colors.grey,
                  onTap: () => authCubit.signInWithGoogle(),
                ),
                SizedBox(height: 8),
                _LoginButton(
                  text: 'Sign in with Email',
                  imagePath: 'assets/icon_email.png',
                  color: Colors.red,
                  textColor: Colors.white,
                  onTap: () {
                    authCubit.reset();
                    Navigator.pushNamed(context, Routes.signInEmail);
                  },
                ),
                SizedBox(height: 8),
                _LoginButton(
                  text: 'Sign in Anonymously',
                  imagePath: 'assets/icon_question.png',
                  color: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  onTap: () => authCubit.signInAnonymously(),
                ),
                SizedBox(height: 48),
                OutlinedButton(
                  child: Text('Create account'),
                  onPressed: () {
                    authCubit.reset();
                    Navigator.pushNamed(context, Routes.createAccount);
                  },
                ),
                SizedBox(height: 48),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback? onTap;
  final Color color;
  final Color textColor;

  const _LoginButton({
    Key? key,
    required this.text,
    required this.imagePath,
    this.onTap,
    this.color = Colors.blue,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      elevation: 3,
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: 24,
                height: 24,
              ),
              SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
