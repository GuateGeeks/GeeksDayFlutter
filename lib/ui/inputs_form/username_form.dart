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
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.name,
          controller: usernameController,
          validator: emailAndUsernameValidator,          
          decoration: InputDecoration(
            hintText: "Ingresa tu nombre de usuario",
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          ),
          // validator: emailValidator,
        );
      
  }
}
