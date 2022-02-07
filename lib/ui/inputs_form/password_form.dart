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
      style: TextStyle(color: Colors.black54),
      textInputAction: TextInputAction.go,
      keyboardType: TextInputType.visiblePassword,
      obscureText: showPassword,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0E89AF)),
        ),
        enabledBorder: InputBorder.none,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(3),
        ),
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
        // hintText: "Enter your Password",
        hintText: "Ingresa tu contraseña",
        hintStyle: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: widget.passwordValidator,
      controller: widget.passwordController,
    );
  }
}
