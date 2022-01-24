import 'package:flutter/material.dart';

class EmailForm extends StatelessWidget {
  String? Function(String? value) emailAndUsernameValidator;
  TextEditingController emailController;
  EmailForm(this.emailAndUsernameValidator, this.emailController);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black54),
      keyboardType: TextInputType.emailAddress,
      validator: emailAndUsernameValidator,
      controller: emailController,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0E89AF)),
        ),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.black54),
        filled: true,
      ),
    );
  }
}
