import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailCreate extends StatefulWidget {
  static Widget create(BuildContext context) => EmailCreate();

  @override
  _EmailCreateState createState() => _EmailCreateState();
}

class _EmailCreateState extends State<EmailCreate> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  String? emailValidator(String? value) {
    return (value == null || value.isEmpty) ? 'This is a required field' : null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'This is a required field';
    if (value.length < 6) return 'Password should be at least 6 letters';
    if (_passwordController.text != _repeatPasswordController.text)
      return 'Password do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 500 ? 500 : width;
    return Scaffold(
        appBar: AppBar(title: Text('Create account')),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (_, state) {
            return Center(
              child: Container(
                width: maxWidth,
                child: Column(
                  children: [
                    SizedBox(height: 30.0),
                    Text(
                      "Sing Up",
                      style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 50,
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
                            email(),
                            //Show input Username
                            SizedBox(height: 8),
                            username(),
                            SizedBox(height: 8),
                            //Show input Password
                            password(),

                            SizedBox(height: 8),
                            //Show input Repear Password
                            repeatPassword(),
                            SizedBox(height: 18),
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
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    context
                                        .read<AuthCubit>()
                                        .createUserWithEmailAndPassword(
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
                  ],
                ),
              ),
            );
          },
        ));
  }

//Create input Email
  Widget email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            "Email",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: "Enter your email",
            border: InputBorder.none,
            filled: true,
            fillColor: Color.fromRGBO(240, 240, 240, 1),
            contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
            ),
          ),
          validator: emailValidator,
        ),
      ],
    );
  }

//Create input Username
  Widget username() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            "Username",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.name,
          controller: _emailController,
          cursorColor: Color.fromRGBO(170, 170, 170, 1),
          decoration: InputDecoration(
            hintText: "Enter your username",
            border: InputBorder.none,
            filled: true,
            fillColor: Color.fromRGBO(240, 240, 240, 1),
            contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
            ),
          ),
          validator: emailValidator,
        ),
      ],
    );
  }

//Create input Password
  Widget password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            "Password",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
          ),
        ),
        inputsPassword(
            _passwordController, "Password", passwordValidator, true),
      ],
    );
  }

//Create input RepeatPassword
  Widget repeatPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            "Repear Password",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
          ),
        ),
        inputsPassword(_repeatPasswordController, "Repeat Password",
            passwordValidator, true),
      ],
    );
  }

//This function creates the layout of the input password, and repeatpassword
  Widget inputsPassword(controller, placeholder, validator, showText) {
    return TextFormField(
      obscureText: showText,
      controller: controller,
      cursorColor: Color.fromRGBO(170, 170, 170, 1),
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.visibility,
        ),
        hintText: placeholder,
        border: InputBorder.none,
        filled: true,
        fillColor: Color.fromRGBO(240, 240, 240, 1),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8),
          borderSide: new BorderSide(
            color: Color.fromRGBO(240, 240, 240, 1),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: new BorderRadius.circular(8),
          borderSide: new BorderSide(
            color: Color.fromRGBO(240, 240, 240, 1),
          ),
        ),
      ),
      validator: validator,
    );
  }
}
