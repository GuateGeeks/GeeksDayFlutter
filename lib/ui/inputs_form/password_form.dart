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
            "Password",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
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
            hintText: "Enter your Password",
            border: InputBorder.none,
            filled: true,
            fillColor: Color.fromRGBO(240, 240, 240, 1),
            contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: Color.fromRGBO(240, 240, 240, 1),
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
