import 'package:flutter/material.dart';

class UsernameForm extends StatelessWidget {
  String? Function(String? value) emailAndUsernameValidator;
  TextEditingController usernameController;
  UsernameForm(this.emailAndUsernameValidator, this.usernameController,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black54),
      keyboardType: TextInputType.name,
      controller: usernameController,
      validator: emailAndUsernameValidator,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0E89AF)),
        ),
        enabledBorder: InputBorder.none,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        hintText: "Nombre de usuario",
        hintStyle: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      // validator: emailValidator,
    );
  }
}
