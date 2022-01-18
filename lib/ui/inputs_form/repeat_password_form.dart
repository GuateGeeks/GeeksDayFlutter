import 'package:flutter/material.dart';

class RepeatPasswordForm extends StatefulWidget {
  String? Function(String? value) passwordValidator;
  TextEditingController repeatPasswordController;
  RepeatPasswordForm(this.passwordValidator, this.repeatPasswordController,
      {Key? key})
      : super(key: key); 

  @override
  _RepeatPasswordFormState createState() => _RepeatPasswordFormState();
}

class _RepeatPasswordFormState extends State<RepeatPasswordForm> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.visiblePassword,
          obscureText: showPassword,
          decoration: InputDecoration(
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
            hintText: "Repetir contraseña",
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          ),
          validator: widget.passwordValidator,
          controller: widget.repeatPasswordController,
        ),
      ],
    );
  }
}
