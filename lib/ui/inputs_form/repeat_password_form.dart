import 'package:flutter/material.dart';

class RepeatPasswordForm extends StatefulWidget {
  String? Function(String? value) passwordValidator;
  TextEditingController repeatPasswordController;
  Function submitForm;
  RepeatPasswordForm(this.passwordValidator, this.repeatPasswordController, this.submitForm,
      {Key? key})
      : super(key: key);

  @override
  _RepeatPasswordFormState createState() => _RepeatPasswordFormState();
}

class _RepeatPasswordFormState extends State<RepeatPasswordForm> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (value) => widget.submitForm(),
      style: TextStyle(color: Colors.black54),
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
        hintText: "Repetir contraseña",
        hintStyle: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: widget.passwordValidator,
      controller: widget.repeatPasswordController,
    );
  }
}
