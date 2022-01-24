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
          style: TextStyle(color: Colors.black54),
          keyboardType: TextInputType.emailAddress,
          validator: emailAndUsernameValidator,
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.black54),
            filled: true,
          ),
        ),
      ],
    );
  }
}
