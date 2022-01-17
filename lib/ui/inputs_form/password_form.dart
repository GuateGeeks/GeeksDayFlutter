import 'package:flutter/material.dart';

class PasswordForm extends StatefulWidget {
  String? Function(String? value) passwordValidator;
  TextEditingController passwordController;

  PasswordForm(
    this.passwordValidator,
    this.passwordController, {
    Key? key,
  }) : super(key: key);

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: showPassword,
      
      decoration: InputDecoration(
        hintText: "Contraseña",
        // border: OutlineInputBorder(),
        hintStyle: TextStyle(color: Colors.black), 
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        suffixIcon: InkWell(
           onTap: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            child: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
            ),
        ),
      ),
    );
  }
}
