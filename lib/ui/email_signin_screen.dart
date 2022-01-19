import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:geeksday/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        title: Text('Iniciar sesión con Email'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient( 
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0E89AF),
                Color(0xFF4B3BAB),
              ]),
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
                      height: 10,
                    ),
                    formLogin(state),
                    SizedBox(
                      height: 15
                    ),
                    forgotPassword(),
                    SizedBox( 
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
            
              Container(
                margin: EdgeInsets.only(top: 340),
                child: ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(120, 40)),
                    side: MaterialStateProperty.all(
                    const BorderSide(
                      color: Color.fromRGBO(255, 255, 255, 0.79),
                      width: 1,
                    ),
                  ),
                    backgroundColor:  MaterialStateProperty.all<Color>(Color.fromRGBO(75, 59, 171, 1)),
                  ),
                  onPressed: () {
                    authCubit.reset();
                    Navigator.pushNamed(context, Routes.createAccount);
                  },
                  child: Text("Registrarse",
                    style: TextStyle(  
                      fontSize: 17.0,
                      color: Colors.white,
                      // fontFamily: 'Biryani',
                    ),
                  )
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
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xFF0E89AF),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 24)),
          ),
          child: Center(
            child: Text(
              "Ingresar",
              style: TextStyle(
                fontSize: 17,
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

  Widget forgotPassword(){
    return InkWell(
      onTap: (){},
      child: Text("Recuperar contraseña",
        style: TextStyle(  
          color: Color(0xFF4A4A4A),
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
      ),
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
