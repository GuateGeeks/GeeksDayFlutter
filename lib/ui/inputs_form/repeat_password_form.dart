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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            "Repeat Password",
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
            hintText: "Enter your Password",
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
          controller: widget.repeatPasswordController,
        ),
      ],
    );
  }
}
