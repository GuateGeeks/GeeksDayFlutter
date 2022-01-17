import 'package:flutter/material.dart';

class EmailForm extends StatelessWidget {
  String? Function(String? value) emailAndUsernameValidator;
  TextEditingController emailController;
  EmailForm(this.emailAndUsernameValidator, this.emailController);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: emailAndUsernameValidator,
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.black),
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
