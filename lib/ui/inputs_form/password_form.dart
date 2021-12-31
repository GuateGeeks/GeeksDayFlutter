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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            "Contraseña",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        TextFormField(
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
            hintText: "Ingresa tu contraseña",
            border: InputBorder.none,
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          validator: widget.passwordValidator,
          controller: widget.passwordController,
        ),
      ],
    );
  }
}
