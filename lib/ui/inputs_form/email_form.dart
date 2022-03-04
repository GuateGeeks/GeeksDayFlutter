import 'package:flutter/material.dart';

class EmailForm extends StatelessWidget {
  String? Function(String? value) emailAndUsernameValidator;
  TextEditingController emailController;
  Function submitForm;
  EmailForm(this.emailAndUsernameValidator, this.emailController, this.submitForm);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (vallue) => submitForm(),
      style: TextStyle(color: Colors.black54),
      keyboardType: TextInputType.emailAddress,
      validator: emailAndUsernameValidator,
      controller: emailController,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0E89AF)),
        ),
        enabledBorder: InputBorder.none,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        hintText: "Email",
        hintStyle: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
